{% if pillar['network'] is defined %}

include:
  - .config

{% endif %}
