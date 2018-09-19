mod-headers:
  cmd.run:
    - name: a2enmod headers
    - unless: ls /etc/apache2/mods-enabled/headers.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
