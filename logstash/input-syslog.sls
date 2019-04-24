{% from 'logstash/map.jinja' import logstash with context %}

input-syslog_conf:
  file.managed:
    - name: /etc/logstash/conf.d/input-syslog.conf
    - source: salt://logstash/files/input-syslog.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ logstash.config|tojson }}
    - require:
      - pkg: logstash
    - watch_in:
      - service: logstash
