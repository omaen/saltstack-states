fstrim_service:
  file.managed:
    - name: /etc/systemd/system/fstrim.service
    - source: salt://fstrim/files/fstrim.service
    - user: root
    - group: root
    - mode: 644

fstrim_timer:
  file.managed:
    - name: /etc/systemd/system/fstrim.timer
    - source: salt://fstrim/files/fstrim.timer
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: fstrim.timer
    - enable: True
    - require:
      - file: fstrim_service
      - file: fstrim_timer
