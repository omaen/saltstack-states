{% from 'logstash/map.jinja' import logstash with context %}

output-elasticsearch_conf:
  file.managed:
    - name: /etc/logstash/conf.d/output-elasticsearch.conf
    - source: salt://logstash/files/output-elasticsearch.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
      config: {{ logstash.config }}
    - require:
      - pkg: logstash
    - watch_in:
      - service: logstash
