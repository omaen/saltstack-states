{% if pillar['dnsmasq'] is defined %}
include:
  - dnsmasq.package
  - dnsmasq.config
{% else %}
include:
  - dnsmasq.remove
{% endif %}
