mod-deflate:
  cmd.run:
    - name: a2enmod deflate
    - unless: apache2ctl -M | grep ' deflate_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2
