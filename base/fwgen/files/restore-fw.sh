#!/bin/sh

IPSETS_RESTORE="/etc/ipsets.restore"
IPTABLES_RESTORE="/etc/iptables.restore"
IP6TABLES_RESTORE="/etc/ip6tables.restore"


[ -f ${IPSETS_RESTORE} ] && ipset restore < "${IPSETS_RESTORE}"
[ -f ${IPTABLES_RESTORE} ] && iptables-restore < "${IPTABLES_RESTORE}"
[ -f ${IP6TABLES_RESTORE} ] && ip6tables-restore < "${IP6TABLES_RESTORE}"
