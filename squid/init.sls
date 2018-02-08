{% if pillar['squid'] is defined %}

include:
  - .install
  - .config

{% endif %}
