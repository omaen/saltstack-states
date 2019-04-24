{% from 'krb5/map.jinja' import krb5 with context %}

krb5_conf:
  file.managed:
    - name: /etc/krb5.conf
    - source: salt://krb5/files/krb5.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ krb5.config|tojson }}

krb5_keytab:
  group.present:
    - name: keytab
  file.managed:
    - name: /etc/krb5.keytab
    - user: root
    - group: keytab
    - mode: 640
    - replace: False
    - create: False
    - require:
      - group: krb5_keytab
