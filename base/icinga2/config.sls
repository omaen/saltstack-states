{% from 'icinga2/map.jinja' import icinga2 with context %}

icinga2_conf:
  file.managed:
    - name: /etc/icinga2/icinga2.conf
    - source: salt://icinga2/files/icinga2.conf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: icinga2
    - require:
      - cmd: icinga2-client-setup

zones_conf:
  file.managed:
    - name: /etc/icinga2/zones.conf
    - source: salt://icinga2/files/zones.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ icinga2.config }}
    - watch_in:
      - service: icinga2
    - require:
      - cmd: icinga2-client-setup

api_conf:
  file.managed:
    - name: /etc/icinga2/features-available/api.conf
    - source: salt://icinga2/files/api.conf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: icinga2
    - require:
      - cmd: icinga2-client-setup
