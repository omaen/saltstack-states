mod-http2:
  cmd.run:
    - name: a2enmod http2
    - unless: ls /etc/apache2/mods-enabled/http2.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
