{% if salt['pillar.get']('snmpd:enable', False) %}

include:
  - snmpd.package
  - snmpd.config

{% endif %}
