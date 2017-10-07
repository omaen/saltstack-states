exim4_conf:
  file.managed:
    - name: /etc/exim4/update-exim4.conf.conf
    - source: salt://exim4/files/update-exim4.conf.conf.tmpl
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - watch_in:
      - service: exim4
    - require:
      - pkg: exim4

smtp_listener_options:
  file.replace:
    - name: /etc/default/exim4
    - pattern: ^SMTPLISTENEROPTIONS=.*$
    - repl: SMTPLISTENEROPTIONS='{{ salt['pillar.get']('exim4:smtp_listener_options', '') }}'
    - require:
      - pkg: exim4
    - watch_in:
      - service: exim4
