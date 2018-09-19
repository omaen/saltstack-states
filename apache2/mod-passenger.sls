mod-passenger:
  pkg.installed:
    - name: libapache2-mod-passenger
    - require:
      - pkg: apache2
  cmd.run:
    - name: a2enmod passenger
    - unless: ls /etc/apache2/mods-enabled/passenger.load
    - require:
      - pkg: mod-passenger
    - watch_in:
      - service: apache2-restart
