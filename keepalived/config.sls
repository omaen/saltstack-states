{% from 'keepalived/map.jinja' import keepalived with context %}

include:
  - systemd.daemon-reload

keepalived_conf:
  file.managed:
    - name: {{ keepalived.config_file }}
    - source: salt://keepalived/files/keepalived.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - context:
        # Filter via json to get some sane ordering
        config: {{ keepalived.config|json }}
    - watch_in:
      - service: {{ keepalived.service }}

keepalived.service:
{% if salt.pillar.get('keepalived:service_config') %}
  file.managed:
    - name: /etc/systemd/system/keepalived.service
    - source: salt://systemd/files/service.tmpl
    - template: jinja
    - onlyif: systemctl is-enabled keepalived.service
    - mode: 644
    - user: root
    - group: root
    - context:
        # Filter via json to get some sane ordering
        config: {{ keepalived.service_config|json }}
{% else %}
  file.absent:
    - name: /etc/systemd/system/keepalived.service
{% endif %}
    - watch_in:
      - cmd: daemon-reload
      - service: keepalived
