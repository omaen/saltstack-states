include:
  - .apache2-keytab

mod-auth_kerb:
  pkg.installed:
    - name: libapache2-mod-auth-kerb
    - require:
      - pkg: apache2
      - user: user_apache2
  cmd.run:
    - name: a2enmod auth_kerb
    - unless: apache2ctl -M | grep ' auth_kerb_module '
    - require:
      - pkg: apache2
      - pkg: mod-auth_kerb
    - watch_in:
      - service: apache2
