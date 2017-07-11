{% if pillar['filebeat'] is defined %}

include:
  - filebeat.package
  - filebeat.config

{% endif %}
