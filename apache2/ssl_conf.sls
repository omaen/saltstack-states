include:
  - apache2

ssl_conf:
  file.managed:
    - name: /etc/apache2/mods-available/ssl.conf
    - source: salt://apache2/files/ssl.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2
