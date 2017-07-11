#!/bin/bash

set -o nounset
set -o errexit

VTI_IF="${1}"
VTI_ADDR="${2:-}"

case "${PLUTO_VERB}" in
    up-client)
        ip tunnel add "${VTI_IF}" \
            local "${PLUTO_ME}" \
            remote "${PLUTO_PEER}" \
            mode vti \
            okey "${PLUTO_MARK_OUT%%/*}" \
            ikey "${PLUTO_MARK_IN%%/*}"
        sysctl -w "net.ipv4.conf.${VTI_IF}.disable_policy=1"
        sysctl -w "net.ipv4.conf.${VTI_IF}.rp_filter=2"
        ip link set "${VTI_IF}" up

        # Configure virtual IP if used as a roadwarrior.
        # As nounset are set ensure there is a empty string if test value is
        # not set to prevent the script from exiting prematurely.
        if [[ -n ${PLUTO_MY_SOURCEIP:-} ]]; then
            ip addr add "${PLUTO_MY_SOURCEIP}" dev "${VTI_IF}"
            ip route add "${PLUTO_PEER_CLIENT}" dev "${VTI_IF}"
        fi

        if [[ -n ${VTI_ADDR} ]]; then
            ip addr add "${VTI_ADDR}" dev "${VTI_IF}"
        fi
        ;;
    down-client)
        ip tunnel del "${VTI_IF}"
        ;;
esac
