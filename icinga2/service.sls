{% from 'icinga2/map.jinja' import icinga2 with context %}

include:
  - .install

icinga2-service-restart:
  service.running:
    - name: {{ icinga2.service }}
    - enable: True
    - require:
      - pkg: icinga2

icinga2-service-reload:
  service.running:
    - name: {{ icinga2.service }}
    - enable: True
    - reload: True
    - require:
      - pkg: icinga2
