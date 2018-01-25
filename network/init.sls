{% if pillar['network'] is defined %}

include:
  - .install
  - .config

{% endif %}
