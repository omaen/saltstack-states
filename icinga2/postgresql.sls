{% from 'icinga2/map.jinja' import icinga2 with context %}

icinga2-postgresql:
  pkg.installed:
    - name: {{ icinga2.postgresql.pkg }}
  service.running:
    - name: {{ icinga2.postgresql.service }}
    - reload: True
    - enable: True
    - require:
      - pkg: icinga2-postgresql
