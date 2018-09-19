mod-authnz_ldap:
  cmd.run:
    - name: a2enmod authnz_ldap
    - unless: ls /etc/apache2/mods-enabled/authnz_ldap.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2-restart
