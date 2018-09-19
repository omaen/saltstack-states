mod-rewrite:
  cmd.run:
    - name: a2enmod rewrite
    - unless: ls /etc/apache2/mods-enabled/rewrite.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
