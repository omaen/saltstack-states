{% if pillar['bird'] is defined %}

include:
  - .install
  - .config

{% endif %}
