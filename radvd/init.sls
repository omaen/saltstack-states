{% if pillar['radvd'] is defined %}

include:
  - .install
  - .config

{% endif %}
