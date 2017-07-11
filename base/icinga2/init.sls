{% if pillar['icinga2'] is defined %}

{% if salt['pillar.get']('icinga2:ticket') %}
include:
  - icinga2.package
  - icinga2.config
  - icinga2.command-execution-client
{% endif %}

{% endif %}
