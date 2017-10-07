mod-userdir:
  cmd.run:
    - name: a2enmod userdir
    - unless: apache2ctl -M | grep ' userdir_module '
    - watch_in:
      - service: apache2
