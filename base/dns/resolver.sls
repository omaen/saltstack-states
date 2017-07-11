include:
  - resolvconf
{% if pillar['dnsmasq'] is defined %}
  - dnsmasq
#{% else %}
#  - systemd-resolved
{% endif %}
