iptables-gen_remove:
  file.absent:
    - names:
      - /usr/local/bin/iptables-gen
      - /usr/local/lib/iptables-gen/common
      - /etc/network/if-pre-up.d/restore-fw
      - /usr/local/bin/restore-fw
      - /etc/iptables.restore
      - /etc/ip6tables.restore
      - /etc/ipsets.restore
