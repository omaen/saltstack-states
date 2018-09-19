mod-proxy_http:
  cmd.run:
    - name: a2enmod proxy_http
    - unless: ls /etc/apache2/mods-enabled/proxy_http.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
