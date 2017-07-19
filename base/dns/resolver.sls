include:
  - resolvconf
{% if pillar['dnsmasq'] is defined %}
  - dnsmasq
{% else %}
  - dnsmasq.remove
{% endif %}
