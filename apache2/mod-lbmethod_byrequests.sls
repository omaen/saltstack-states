mod-lbmethod_byrequests:
  cmd.run:
    - name: a2enmod lbmethod_byrequests
    - unless: ls /etc/apache2/mods-enabled/lbmethod_byrequests.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
