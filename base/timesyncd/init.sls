{% if pillar['ntp'] is not defined %}

include:
  - ntp.remove
  - .config

{% endif %}
