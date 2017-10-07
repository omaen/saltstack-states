syslog:
  pkg.installed:
    - name: rsyslog
  service.running:
    - name: rsyslog
    - require:
        - pkg: syslog
