include:
  - dovecot.imap
  - dovecot.managesieve
{% if salt['pillar.get']('dovecot:enable_ssl', False) %}
  - dovecot.ssl
{% endif %}

dovecot_conf:
  file.managed:
    - name: /etc/dovecot/local.conf
    - source: salt://dovecot/files/local.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: dovecot-imap
      - pkg: dovecot-managesieve
    - watch_in:
      - service: dovecot-imap
