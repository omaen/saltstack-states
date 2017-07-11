include:
  - apache2

disable-default-site:
  cmd.run:
    - name: a2dissite 000-default
    - onlyif: apache2ctl -S | grep 'sites-enabled/000-default.conf'
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2 
