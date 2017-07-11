mod-authnz_ldap:
  cmd.run:
    - name: a2enmod authnz_ldap
    - unless: apache2ctl -M | grep ' authnz_ldap_module '
    - watch_in:
      - service: apache2
    - require:
      - pkg: apache2
