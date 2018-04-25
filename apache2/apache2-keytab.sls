include:
  - apache2
  - krb5

user_apache2:
  user.present:
    - name: www-data
    - groups: ['keytab']
    - remove_groups: False
    - require:
      - pkg: apache2
      - file: krb5_keytab
