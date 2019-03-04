{% from 'icinga2/map.jinja' import icinga2 with context %}

icinga2:
  pkg.installed:
    - name: {{ icinga2.package }}
  service.running:
    - name: {{ icinga2.service }}
    - require:
      - pkg: icinga2
