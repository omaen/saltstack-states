{% if pillar['nftables'] is defined %}
include:
  - nftables
{% elif pillar['fwgen'] is defined %}
include:
  - fwgen
{% elif pillar['firewall'] is defined %}
include:
  - iptables
{% endif %}
