{% from 'keepalived/map.jinja' import keepalived with context %}

keepalived:
  pkg.installed:
    - name: {{ keepalived.package }}
  service.running:
    - enable: True
    - reload: True
    - name: {{ keepalived.service }}
