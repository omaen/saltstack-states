mod-ssl:
  cmd.run:
    - name: a2enmod ssl
    - unless: apache2ctl -M | grep ' ssl_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2
