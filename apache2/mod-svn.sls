mod-svn:
  pkg.installed:
    - name: libapache2-mod-svn
    - require:
      - pkg: apache2
  cmd.run:
    - name: a2enmod dav_svn
    - unless: ls /etc/apache2/mods-enabled/dav_svn.load
    - require:
      - pkg: mod-svn
    - watch_in:
      - service: apache2-restart
