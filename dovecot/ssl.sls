include:
  - dovecot.imap
  - dovecot.conf

{% if salt['pillar.get']('dovecot:certificate', False) %}
ssl_cert:
  file.managed:
    - name: /etc/dovecot/certs/dovecot.pem
    - contents_pillar: 'dovecot:certificate'
    - user: root
    - group: root
    - makedirs: True
    - mode: 644
    - watch_in:
      - service: dovecot-imap
    - require:
      - pkg: dovecot-imap
    - require_in:
      - file: dovecot_conf

ssl_key:
  file.managed:
    - name: /etc/dovecot/private/dovecot.pem
    - contents_pillar: 'dovecot:key'
    - user: root
    - group: root
    - mode: 600
    - watch_in:
      - service: dovecot-imap
    - require:
      - pkg: dovecot-imap
    - require_in:
      - file: dovecot_conf
{% endif %}
