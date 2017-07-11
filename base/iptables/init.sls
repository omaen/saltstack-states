{% if pillar['firewall'] is defined %}

include:
  - .package
  - .config

{% endif %}
