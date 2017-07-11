{% if pillar['proxy'] is defined %}

include:
  - .config

{% endif %}
