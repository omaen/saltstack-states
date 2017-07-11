{% from 'filebeat/map.jinja' import filebeat with context %}

filebeat_yml:
  file.managed:
    - name: /etc/filebeat/filebeat.yml
    - source: salt://filebeat/files/filebeat.yml
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
      config: {{ filebeat.config }}
    - watch_in:
      - service: filebeat
    - require:
      - pkg: filebeat
