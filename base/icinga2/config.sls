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
