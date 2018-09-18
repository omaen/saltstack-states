{% if pillar['systemd_networkd'] is defined %}

include:
  - .config

{% endif %}
