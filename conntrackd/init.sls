{% if pillar['conntrackd'] is defined %}

include:
  - .install
  - .config

{% endif %}
