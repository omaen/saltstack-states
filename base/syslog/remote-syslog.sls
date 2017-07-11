include:
  - syslog

remote-syslog_conf:
  file.managed:
    - name: /etc/rsyslog.d/remote-syslog.conf
    - source: salt://syslog/files/remote-syslog.conf.tmpl
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: syslog
    - require:
      - pkg: syslog
