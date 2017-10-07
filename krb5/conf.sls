krb5_conf:
  file.managed:
    - name: /etc/krb5.conf
    - source: salt://krb5/files/krb5.conf.tmpl
    - template: jinja
    - user: root
    - group: root
    - mode: 644
