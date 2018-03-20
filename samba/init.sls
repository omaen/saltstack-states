{% if pillar['samba'] is defined %}

include:
  - .install
  - .config

{% endif %}
