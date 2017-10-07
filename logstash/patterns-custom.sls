patterns-custom:
  file.managed:
    - name: /etc/logstash/patterns/custom
    - source: salt://logstash/files/patterns-custom
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - watch_in:
      - service: logstash
