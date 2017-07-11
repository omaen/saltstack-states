{% if pillar['bird'] is defined %}

include:
  - .package
  - .config

{% endif %}
