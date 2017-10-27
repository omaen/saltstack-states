{% from 'icinga2/map.jinja' import icinga2 with context %}

include:
  - .master
  - mariadb.server

icinga2-feature-ido-mysql:
  debconf.set:
    - name: {{ icinga2.ido_mysql.package }}
    - data:
        icinga2-ido-mysql/mysql/app-pass:
          type: password
          value: {{ icinga2.ido_mysql.db_password }}
        icinga2-ido-mysql/app-password-confirm:
          type: password
          value: {{ icinga2.ido_mysql.db_password }}
  pkg.installed:
    - name: {{ icinga2.ido_mysql.package }}
    - require:
      - debconf: icinga2-feature-ido-mysql
      - service: mariadb
  cmd.run:
    - name: icinga2 feature enable ido-mysql
    - unless: test -L /etc/icinga2/features-enabled/ido-mysql.conf
    - require:
      - pkg: icinga2-feature-ido-mysql
    - watch_in:
      - service: icinga2
  file.replace:
    - name: /etc/icinga2/features-enabled/ido-mysql.conf
    - pattern: ^\s+password = ".*",
    - repl: '  password = "{{ icinga2.ido_mysql.db_password }}",'
    - count: 1
    - require:
      - cmd: icinga2-feature-ido-mysql
    - watch_in:
      - service: icinga2
  mysql_user.present:
    - name: {{ icinga2.ido_mysql.db_user }}
    - host: localhost
    - password: {{ icinga2.ido_mysql.db_password }}
    - require:
      - cmd: icinga2-feature-ido-mysql
      - service: mariadb
      - pkg: python-mysqldb
