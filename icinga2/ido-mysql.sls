{% from 'icinga2/map.jinja' import icinga2 with context %}

include:
  - .master
  - mariadb.server

icinga2-feature-ido-mysql:
  pkg.installed:
    - name: {{ icinga2.ido_mysql.package }}
    - require:
      - service: mariadb
  cmd.run:
    - name: icinga2 feature enable ido-mysql
    - unless: test -L /etc/icinga2/features-enabled/ido-mysql.conf
    - require:
      - pkg: icinga2-feature-ido-mysql
    - watch_in:
      - service: icinga2
