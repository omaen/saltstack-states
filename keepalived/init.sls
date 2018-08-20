{% if pillar['keepalived'] is defined %}

include:
  - .install
  - .config

{% endif %}
