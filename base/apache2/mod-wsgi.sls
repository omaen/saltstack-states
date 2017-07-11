mod-wsgi:
  pkg.installed:
    - name: libapache2-mod-wsgi
    - require:
      - pkg: apache2
  cmd.run:
    - name: a2enmod wsgi
    - unless: apache2ctl -M | grep ' wsgi_module '
    - require:
      - pkg: mod-wsgi
    - watch_in:
      - service: apache2
