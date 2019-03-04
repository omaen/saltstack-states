{% from 'icinga2/map.jinja' import icinga2 with context %}

include:
  - mariadb.server
  - apache2.package
  - apache2.php-timezone

icingaweb2:
  pkg.installed:
    - name: {{ icinga2.icingaweb2.package }}
    - watch_in:
      - service: apache2
  cmd.run:
    - name: icinga2 feature enable command
    - unless: test -L /etc/icinga2/features-enabled/command.conf
    - require:
      - pkg: icingaweb2
    - watch_in:
      - service: icinga2

create-icingaweb2-db:
  mysql_database.present:
    - name: icingaweb2
    - require:
      - service: mariadb
      - pkg: python-mysqldb
  mysql_user.present:
    - name: icingaweb2
    - host: localhost
    - password: {{ icinga2.icingaweb2.configs.resources.icingaweb_db.password }}
    - require:
      - service: mariadb
      - pkg: python-mysqldb
  mysql_grants.present:
    - grant: all
    - database: icingaweb2.*
    - user: icingaweb2
    - host: localhost
    - require:
      - mysql_user: create-icingaweb2-db
      - mysql_database: create-icingaweb2-db

{% for config, params in icinga2.icingaweb2.configs.items() %}

icingaweb2_{{ config }}_ini:
  file.managed:
    - name: /etc/icingaweb2/{{ config }}.ini
    - source: salt://icinga2/files/template.ini
    - template: jinja
    - user: www-data
    - group: icingaweb2
    - mode: 660
    - context:
        config: {{ params }}
    - require:
      - pkg: icingaweb2

{% endfor %}

icingaweb2-module-monitoring:
  cmd.run:
    - name: icingacli module enable monitoring
    - unless: test -L /etc/icingaweb2/enabledModules/monitoring
    - require:
      - pkg: icingaweb2

icingaweb2-module-doc:
  cmd.run:
    - name: icingacli module enable doc
    - unless: test -L /etc/icingaweb2/enabledModules/doc
    - require:
      - pkg: icingaweb2

{% for module, configs in icinga2.icingaweb2.modules.items() %}
{% for config, params in configs.items() %}

icingaweb2_{{ module}}_{{ config }}_ini:
  file.managed:
    - name: /etc/icingaweb2/modules/{{ module }}/{{ config }}.ini
    - source: salt://icinga2/files/template.ini
    - template: jinja
    - user: www-data
    - group: icingaweb2
    - mode: 660
    - dir_mode: 2770
    - makedirs: True
    - context:
        config: {{ params }}
    - require:
      - cmd: icingaweb2-module-{{ module }}

{% endfor %}
{% endfor %}
