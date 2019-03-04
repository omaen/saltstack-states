#!/bin/sh

set -e

user="{{ config.user }}"
realm="{{ config.realm }}"
domain="{{ config.domain }}"
keytab="{{ config.user_keytab }}"
computer_ou="{{ config.computer_ou }}"
retry_count=1


# Do not continue if DNS is not working to prevent the script from removing
# a working keytab and join just because there are some DNS issues
if ! host -t srv _kerberos._tcp.${realm}; then
    exit 1
fi

[ -f /etc/krb5.keytab ] && rm /etc/krb5.keytab

kinit ${user}@${realm} -k -t "${keytab}"

# adcli has some noteable quirks.
# 1) If you do not add --host-fqdn manually it ends up using the non-fqdn hostname,
#    unless the static hostname is set to the FQDN, i.e that /etc/hostname contains the FQDN
#    instead of the shortname. See hostnamectl output.
#    If the fqdn is not set correctly _no_ servicePrincipleName attributes will be
#    added to the computer object in AD, so nothing works.
# 2) By default 'host' and 'RestrictedKrbHost' service names are added. However, if
#    you manually add one or more service names, those are no longer added, so you have to
#    ensure those are in the list if you have more service names to add and need them for
#    ssh access etc.
adcli join \
    --domain="${domain}" \
    --domain-ou="${computer_ou}" \
    --host-fqdn="$(hostname -f)" \
    --service-name=host \
    --service-name=RestrictedKrbHost \
{%- for spn in config.service_principals %}
    --service-name={{ spn }} \
{%- endfor %}
    --login-user=${user}@${realm} \
    --login-ccache \
    --show-details

kdestroy
