mod-svn:
  pkg.installed:
    - name: libapache2-mod-svn
    - require:
      - pkg: apache2
  cmd.run:
    - name: a2enmod dav_svn
    - unless: apache2ctl -M | grep ' dav_svn_module '
    - require:
      - pkg: apache2
      - pkg: mod-svn
    - watch_in:
      - service: apache2
