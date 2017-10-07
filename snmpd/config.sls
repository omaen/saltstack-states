{% from 'snmpd/map.jinja' import snmpd with context %}

snmpd_conf:
  file.managed:
    - name: {{ snmpd.config_file }}
    - source: salt://snmpd/files/snmpd.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - context:
        config: {{ snmpd.config }}
    - require:
      - pkg: {{ snmpd.package }}
    - watch_in:
      - service: {{ snmpd.service }}
