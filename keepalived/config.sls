{% from 'keepalived/map.jinja' import keepalived with context %}

keepalived_conf:
  file.managed:
    - name: {{ keepalived.config_file }}
    - source: salt://keepalived/files/keepalived.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - context:
        # Filter via json just to get some sane ordering
        config: {{ keepalived.config|json }}
    - watch_in:
      - service: {{ keepalived.service }}
