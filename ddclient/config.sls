{% from 'ddclient/map.jinja' import ddclient with context %}

ddclient_conf:
  file.managed:
    - name: {{ ddclient.config_file }}
    - source: salt://ddclient/files/ddclient.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - context:
        global: {{ ddclient.global }}
        host_definitions: {{ ddclient.host_definitions }}
    - require:
      - pkg: ddclient
    - watch_in:
      - service: ddclient
