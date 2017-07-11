{% if salt['pillar.get']('dnsmasq', {}) %}
include:
  - dnsmasq.package
  - dnsmasq.config
{% else %}
include:
  - dnsmasq.remove
{% endif %}
