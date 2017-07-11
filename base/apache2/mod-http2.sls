mod-http2:
  cmd.run:
    - name: a2enmod http2
    - unless: apache2ctl -M | grep ' http2_module '
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2
