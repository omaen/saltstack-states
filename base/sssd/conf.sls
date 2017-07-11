include:
  - sssd

sssd_conf:
  file.managed:
    - name: /etc/sssd/sssd.conf
    - source: salt://sssd/files/sssd.conf.tmpl
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - require:
      - pkg: sssd-common
