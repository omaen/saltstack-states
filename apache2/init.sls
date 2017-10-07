{% if pillar['apache2'] is defined %}

include:
  - .package
  - .config

{% endif %}
