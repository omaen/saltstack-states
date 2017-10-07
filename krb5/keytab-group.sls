group_keytab:
  group.present:
    - name: keytab

krb5_keytab:
  file.managed:
    - name: /etc/krb5.keytab
    - user: root
    - group: keytab
    - mode: 640
    - replace: False
    - create: False
    - require:
      - group: group_keytab
