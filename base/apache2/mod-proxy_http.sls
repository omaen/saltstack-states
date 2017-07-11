mod-proxy_http:
  cmd.run:
    - name: a2enmod proxy_http
    - unless: apache2ctl -M | grep ' proxy_http_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2
