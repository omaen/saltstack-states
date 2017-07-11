{% from 'snmpd/map.jinja' import snmpd with context %}

snmpd:
  pkg.installed:
    - name: {{ snmpd.package }}
  service.running:
    - name: {{ snmpd.service }}
