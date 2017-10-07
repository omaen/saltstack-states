{% from 'filebeat/map.jinja' import filebeat with context %}

include:
  - logstash.repo-elastic-5_x

filebeat:
  pkg.installed:
    - name: {{ filebeat.package }}
    - require:
      - pkgrepo: repo-elastic-5_x
  service.running:
    - name: {{ filebeat.service }}
    - require:
      - pkg: filebeat
