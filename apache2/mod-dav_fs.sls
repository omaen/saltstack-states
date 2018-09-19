mod-dav_fs:
  cmd.run:
    - name: a2enmod dav_fs
    - unless: ls /etc/apache2/mods-enabled/dav_fs.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
