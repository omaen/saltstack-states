input-netflow_conf:
  file.managed:
    - name: /etc/logstash/conf.d/input-netflow.conf
    - source: salt://logstash/files/input-netflow.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: logstash
    - watch_in:
      - service: logstash
