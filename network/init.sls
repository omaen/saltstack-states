{% if pillar['network'] is defined %}

include:
  - .packages
  - .config

{% endif %}
