mod-deflate:
  cmd.run:
    - name: a2enmod deflate
    - unless: ls /etc/apache2/mods-enabled/deflate.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
