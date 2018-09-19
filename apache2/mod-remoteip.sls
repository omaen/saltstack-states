mod-remoteip:
  cmd.run:
    - name: a2enmod remoteip
    - unless: ls /etc/apache2/mods-enabled/remoteip.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
