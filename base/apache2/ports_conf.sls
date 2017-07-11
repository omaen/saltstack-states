include:
  - apache2

ports_conf:
  file.managed:
    - name: /etc/apache2/ports.conf
    - source: salt://apache2/files/ports.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2
