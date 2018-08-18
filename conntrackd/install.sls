{% from 'conntrackd/map.jinja' import conntrackd with context %}

conntrackd:
  pkg.installed:
    - name: {{ conntrackd.package }}
  service.running:
    - enable: True
    - name: {{ conntrackd.service }}

conntrackd.service:
  file.managed:
    - name: /etc/systemd/system/conntrackd.service
    - source: salt://conntrackd/files/conntrackd.service
    - template: jinja
    - onlyif: systemctl is-enabled conntrackd.service
    - mode: 644
    - user: root
    - group: root
    - require:
      - pkg: conntrackd
  cmd.wait:
    - name: systemctl daemon-reload
    - watch:
      - file: conntrackd.service
