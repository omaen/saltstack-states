mysql-server:
  debconf.set:
    - name: mysql-server
    - data:
        mysql-server/root_password: {'type': 'password', 'value': '{{ salt['pillar.get']('mysql:root_password') }}'}
        mysql-server/root_password_again: {'type': 'password', 'value': '{{ salt['pillar.get']('mysql:root_password') }}'}
  pkg.installed:
    - name: mysql-server
    - require:
      - debconf: mysql-server 
  service.running:
    - name: mysql
    - require:
       - pkg: mysql-server

local_cnf:
  file.managed:
    - name: /etc/mysql/conf.d/local.cnf
    - source: salt://mysql/files/local.cnf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: mysql-server
    - watch_in:
      - service: mysql-server

root_my_cnf:
  file.managed:
    - name: /root/.my.cnf
    - source: salt://mysql/files/.my.cnf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - require:
      - pkg: mysql-server
