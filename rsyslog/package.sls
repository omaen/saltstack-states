{% from 'rsyslog/map.jinja' import rsyslog with context %}

rsyslog:
  pkg.installed:
    - name: {{ rsyslog.package }}
  service.running:
    - name: {{ rsyslog.service }}
    - require:
      - pkg: rsyslog
