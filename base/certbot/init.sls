{% if pillar['certbot'] is defined %}

include:
  - certbot.package

{% endif %}
