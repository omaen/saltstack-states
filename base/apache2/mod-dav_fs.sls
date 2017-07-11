mod-dav_fs:
  cmd.run:
    - name: a2enmod dav_fs
    - unless: apache2ctl -M | grep ' dav_fs_module '
    - watch_in:
      - service: apache2
