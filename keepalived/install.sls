{% from 'keepalived/map.jinja' import keepalived with context %}

keepalived:
  pkg.installed:
    - name: {{ keepalived.package }}
  service.running:
    - enable: True
    - reload: True
    - name: {{ keepalived.service }}

keepalived.service:
{% if keepalived.service_config %}
  file.managed:
    - name: /etc/systemd/system/keepalived.service
    - source: salt://keepalived/files/keepalived.service
    - template: jinja
    - onlyif: systemctl is-enabled keepalived.service
    - mode: 644
    - user: root
    - group: root
    - context:
        config: {{ keepalived.service_config }}
    - require:
      - pkg: keepalived
{% else %}
  file.absent:
    - name: /etc/systemd/system/keepalived.service
    - require:
      - pkg: keepalived
{% endif %}
  cmd.wait:
    - name: systemctl daemon-reload
    - watch:
      - file: keepalived.service
