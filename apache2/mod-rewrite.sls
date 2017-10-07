mod-rewrite:
  cmd.run:
    - name: a2enmod rewrite
    - unless: apache2ctl -M | grep ' rewrite_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2
