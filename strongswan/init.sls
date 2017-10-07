{% if pillar['strongswan'] is defined %}

include:
  - strongswan.package
  - strongswan.config
  - strongswan.certs
  - strongswan.vti

{% endif %}
