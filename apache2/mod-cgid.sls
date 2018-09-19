mod-cgid:
  cmd.run:
    - name: a2enmod cgid
    - unless: ls /etc/apache2/mods-enabled/cgid.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
