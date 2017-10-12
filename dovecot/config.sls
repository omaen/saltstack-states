{% from 'dovecot/map.jinja' import dovecot with context %}

dovecot_conf:
  file.managed:
    - name: {{ dovecot.local_conf }}
    - source: salt://dovecot/files/local.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ dovecot.config }}
    - require:
      - pkg: dovecot
    - watch_in:
      - service: dovecot
