{% if pillar['samba'] is defined %}

include:
  - samba.package
  - samba.config

{% endif %}
