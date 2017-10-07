mod-vhost_alias:
  cmd.run:
    - name: a2enmod vhost_alias
    - unless: apache2ctl -M | grep ' vhost_alias_module '
    - watch_in:
      - service: apache2
