mod-ssl:
  cmd.run:
    - name: a2enmod ssl
    - unless: ls /etc/apache2/mods-enabled/ssl.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
