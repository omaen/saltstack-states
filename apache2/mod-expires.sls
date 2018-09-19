mod-expires:
  cmd.run:
    - name: a2enmod expires
    - unless: ls /etc/apache2/mods-enabled/expires.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
