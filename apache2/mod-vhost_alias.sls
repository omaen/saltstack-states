mod-vhost_alias:
  cmd.run:
    - name: a2enmod vhost_alias
    - unless: ls /etc/apache2/mods-enabled/vhost_alias.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
