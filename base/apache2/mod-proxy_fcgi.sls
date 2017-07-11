mod-proxy_fcgi:
  cmd.run:
    - name: a2enmod proxy_fcgi
    - unless: apache2ctl -M | grep ' proxy_fcgi_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2
