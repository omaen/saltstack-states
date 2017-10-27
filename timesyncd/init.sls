{% if pillar['ntp'] is not defined %}

include:
  - .config

{% endif %}
