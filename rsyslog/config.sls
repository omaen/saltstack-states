{% from 'rsyslog/map.jinja' import rsyslog with context %}

rsyslog_config:
  file.managed:
    - name: {{ rsyslog.config_file }}
    - source: salt://syslog/files/salt.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: rsyslog
    - require:
      - pkg: rsyslog
