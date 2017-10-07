mod-lbmethod_byrequests:
  cmd.run:
    - name: a2enmod lbmethod_byrequests
    - unless: apache2ctl -M | grep ' lbmethod_byrequests_module '
    - watch_in:
      - service: apache2
