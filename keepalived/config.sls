{% from 'keepalived/map.jinja' import keepalived with context %}

include:
  - systemctl.daemon-reload

keepalived_conf:
  file.managed:
    - name: {{ keepalived.config_file }}
    - source: salt://keepalived/files/keepalived.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - context:
        config: {{ keepalived.config|tojson }}
    - watch_in:
      - service: keepalived

/etc/systemd/system/{{ keepalived.service }}.service.d/override.conf:
{% if salt.pillar.get('keepalived:service_config') %}
  file.managed:
    - onlyif: systemctl is-enabled {{ keepalived.service }}.service
    - source: salt://systemd/files/service.tmpl
    - template: jinja
    - makedirs: True
    - mode: 644
    - user: root
    - group: root
    - context:
        config: {{ keepalived.service_config|tojson }}
{% else %}
  file.absent:
{% endif %}
    - watch_in:
      - cmd: daemon-reload
      - service: keepalived

# Workaround for keepalived not setting vip when running ifup manually when
# keepalived is already running
keepalived_ifup:
  file.managed:
    - name: {{ keepalived.ifup }}
    - source: salt://keepalived/files/ifup
    - user: root
    - group: root
    - mode: 755
    - require:
      - service: keepalived
