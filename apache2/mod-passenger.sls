mod-passenger:
  pkg.installed:
    - name: libapache2-mod-passenger
    - require:
      - pkg: apache2
  cmd.run:
    - name: a2enmod passenger
    - unless: apache2ctl -M | grep ' passenger_module '
    - require:
      - pkg: apache2
      - pkg: mod-passenger
    - watch_in:
      - service: apache2
