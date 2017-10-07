mod-cgid:
  cmd.run:
    - name: a2enmod cgid
    - unless: apache2ctl -M | grep ' cgid_module '
    - watch_in:
      - service: apache2
