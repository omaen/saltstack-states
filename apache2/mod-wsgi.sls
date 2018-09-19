mod-wsgi:
  pkg.installed:
    - name: libapache2-mod-wsgi
    - require:
      - pkg: apache2
  cmd.run:
    - name: a2enmod wsgi
    - unless: ls /etc/apache2/mods-enabled/wsgi.load
    - require:
      - pkg: mod-wsgi
    - watch_in:
      - service: apache2-restart
