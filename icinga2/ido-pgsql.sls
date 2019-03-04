{% from 'icinga2/map.jinja' import icinga2 with context %}

include:
  - .service
  - .postgresql

{% if grains['os_family'] == 'Debian' %}
debconf-ido-pgsql:
  debconf.set:
    - name: {{ icinga2.ido.pgsql.pkg }}
    # If you get "error: Cannot find a quiestion for xxx" run "/usr/share/debconf/fix_db.pl" on the target
    - data:
        {{ icinga2.ido.pgsql.pkg }}/dbconfig-install: {'type': 'boolean', 'value': true}
        {{ icinga2.ido.pgsql.pkg }}/db/dbname: {'type': 'string', 'value': "{{ icinga2.ido.db.name if icinga2.ido.db.name is not none else '' }}"}
        {{ icinga2.ido.pgsql.pkg }}/db/app-user: {'type': 'string', 'value': "{{ icinga2.ido.db.user if icinga2.ido.db.user is not none else '' }}"}
        {{ icinga2.ido.pgsql.pkg }}/pgsql/app-pass: {'type': 'password', 'value': "{{ icinga2.ido.db.password if icinga2.ido.db.password is not none else '' }}"}
        {{ icinga2.ido.pgsql.pkg }}/remote/port: {'type': 'string', 'value': "{{ icinga2.ido.db.port if icinga2.ido.db.port is not none else '' }}"}
        {{ icinga2.ido.pgsql.pkg }}/remote/host: {'type': 'select', 'value': "{{ icinga2.ido.db.host if icinga2.ido.db.host is not none else '' }}"}
    - require_in:
      - pkg: icinga2-ido-pgsql
{% endif %}

icinga2-ido-pgsql:
  pkg.installed:
    - name: {{ icinga2.ido.pgsql.pkg }}
{% if icinga2.use_backports %}
    - fromrepo: {{ grains['oscodename']|lower }}-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
    - require:
      - service: icinga2-postgresql
  cmd.run:
    - name: icinga2 feature enable ido-pgsql
    - unless: test -f /etc/icinga2/features-enabled/ido-pgsql.conf
    - require:
      - pkg: icinga2-ido-pgsql
    - watch_in:
      - service: icinga2-service-restart
