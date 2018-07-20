{% from 'hactrl/map.jinja' import hactrl with context %}

hactrl:
  file.managed:
    - name: /usr/local/bin/hactrl
    - source: salt://hactrl/files/hactrl
    - template: jinja
    - mode: 750
    - user: root
    - group: staff
    - context:
        config: {{ hactrl.config }}

hactrl_keepalived.service:
  file.managed:
    - name: /etc/systemd/system/keepalived.service
    - source: salt://hactrl/files/keepalived.service
    - template: jinja
    - onlyif: systemctl is-enabled keepalived.service
    - mode: 644
    - user: root
    - group: root
    - context:
        config: {{ hactrl.config }}
  cmd.wait:
    - name: systemctl daemon-reload
    - watch:
      - file: hactrl_keepalived.service
