#!/bin/sh

set -e

master="${1}"
ticket="${2}"

fqdn=$(hostname --fqdn)
pki_path="/etc/icinga2/pki"
port=5665
user="nagios"
group="nagios"
key="${pki_path}/${fqdn}.key"
cert="${pki_path}/${fqdn}.crt"
trustedcert="${pki_path}/trusted-master.crt"
ca="${pki_path}/ca.crt"


chown ${user}:${group} ${pki_path}

icinga2 pki new-cert \
    --cn $fqdn \
    --key $key \
    --cert $cert

icinga2 pki save-cert \
    --key $key \
    --cert $cert \
    --trustedcert $trustedcert \
    --host $master

icinga2 pki request \
    --host $master \
    --port $port \
    --ticket $ticket \
    --key $key \
    --cert $cert \
    --trustedcert $trustedcert \
    --ca $ca

icinga2 node setup \
    --ticket $ticket \
    --endpoint ${master},${master},${port} \
    --zone $fqdn \
    --master_host $master \
    --trustedcert $trustedcert \
    --accept-commands \
    --accept-config
