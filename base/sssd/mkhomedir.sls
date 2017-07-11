pam-mkhomedir:
  file.managed:
    - name: /usr/share/pam-configs/mkhomedir
    - source: salt://sssd/files/mkhomedir
    - user: root
    - group: root
    - mode: 644
  cmd.wait:
    - name: /usr/sbin/pam-auth-update --package
    - watch:
       - file: pam-mkhomedir
