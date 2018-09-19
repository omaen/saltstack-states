mod-userdir:
  cmd.run:
    - name: a2enmod userdir
    - unless: ls /etc/apache2/mods-enabled/userdir.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
