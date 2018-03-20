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
        config: {{ krb5.config }}
