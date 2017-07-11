input-windowseventlogs_conf:
  file.managed:
    - name: /etc/logstash/conf.d/input-windowseventlogs.conf
    - source: salt://logstash/files/input-windowseventlogs.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: logstash
    - watch_in:
      - service: logstash
