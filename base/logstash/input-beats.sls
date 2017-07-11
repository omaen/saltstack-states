{% from 'logstash/map.jinja' import logstash with context %}

input-beats_conf:
  file.managed:
    - name: /etc/logstash/conf.d/input-beats.conf
    - source: salt://logstash/files/input-beats.conf
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
