{% if pillar['unattended_upgrades'] is defined %}

include:
  - .package
  - .config

{% endif %}
