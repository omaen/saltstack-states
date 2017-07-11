mod-headers:
  cmd.run:
    - name: a2enmod headers
    - unless: apache2ctl -M | grep ' headers_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2
