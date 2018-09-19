mod-wsgi-py3:
  pkg.installed:
    - name: libapache2-mod-wsgi-py3
    - require:
      - pkg: apache2
  cmd.run:
    - name: a2enmod wsgi
    - unless: unless: ls /etc/apache2/mods-enabled/wsgi.load
    - require:
      - pkg: mod-wsgi-py3
    - watch_in:
      - service: apache2-restart
