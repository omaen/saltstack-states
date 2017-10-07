{% if pillar['fwgen'] is defined %}

include:
  - .install
  - .config

{% endif %}
