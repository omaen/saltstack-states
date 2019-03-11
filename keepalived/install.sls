{% from 'keepalived/map.jinja' import keepalived with context %}

keepalived:
  pkg.installed:
    - name: {{ keepalived.package }}
  service.running:
    - enable: True
    - reload: True
    - name: {{ keepalived.service }}

keepalived_proxy_check:
  file.managed:
    - name: /usr/local/bin/proxy-check
    - source: salt://keepalived/files/misc_checks/proxy-check
    - template: jinja
    - user: root
    - group: root
    - mode: 750
