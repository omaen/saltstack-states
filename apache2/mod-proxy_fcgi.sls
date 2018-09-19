mod-proxy_fcgi:
  cmd.run:
    - name: a2enmod proxy_fcgi
    - unless: ls /etc/apache2/mods-enabled/proxy_fcgi.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
