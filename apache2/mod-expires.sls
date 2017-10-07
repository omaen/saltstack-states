mod-expires:
  cmd.run:
    - name: a2enmod expires
    - unless: apache2ctl -M | grep ' expires_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2
