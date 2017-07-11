mod-remoteip:
  cmd.run:
    - name: a2enmod remoteip
    - unless: apache2ctl -M | grep ' remoteip_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2
