#!/bin/sh

set -e

user="{{ config.user }}"
realm="{{ config.realm }}"
keytab="{{ config.user_keytab }}"
computer_ou="{{ config.computer_ou }}"
retry_count=1


kinit ${user}@${realm} -k -t "${keytab}"

# net ads tries to ask for password before trying the kerberos credentials when
# executed via salt-call. Work around by giving it /dev/null as stdin
#
# Also, net ads join fail if the computer object already exists _and_ the host is
# trusted for kerberos delegation. In those cases it only deletes the computer
# account, so as a workaround it is run again to actually successfully join the computer.
# This is not needed when using an admin account. For the saltstack user however, a single
# join wont work even when it is given full control of all objects within its delegated OU.
count=0
while ! net ads join createcomputer="${computer_ou}" -k -U ${user}@${realm} < /dev/null; do
    if [ $count -ge $retry_count ]; then
        exit 1
    fi
    count=$((count + 1))
    sleep 3
done

{%- for spn in config.service_principals %}
net ads keytab add {{ spn }} -k
{%- endfor %}
kdestroy
