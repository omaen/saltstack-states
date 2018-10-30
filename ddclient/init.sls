{% if pillar['ddclient'] is defined %}

include:
  - .install
  - .config

{% endif %}
