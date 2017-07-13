{% from 'mariadb-backup/map.jinja' import mariadb_backup with context %}

mariadb-backup_config:
  file.managed:
    - name: {{ mariadb_backup.config_file }}
    - source: salt://mariadb-backup/files/config
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - context:
        config: {{ mariadb_backup.config }}


{% if mariadb_backup.cron_enable %}

{% if mariadb_backup.config.keep_daily is defined and mariadb_backup.config.keep_daily > 0 %}
mariadb-backup_cron_daily:
  cron.present:
    {% if mariadb_backup.nice %}
    - name: nice {{ mariadb_backup.bin }} daily
    {% else %}
    - name: {{ mariadb_backup.bin }} daily
    {% endif %}
    - identifier: mariadb-backup daily backup
    - user: root
    - hour: random
    - minute: random
{% else %}
include:
  - .remove_daily_cronjob
{% endif %}

{% if mariadb_backup.config.keep_monthly is defined and mariadb_backup.config.keep_monthly > 0 %}
mariadb-backup_cron_monthly:
  cron.present:
    {% if mariadb_backup.nice %}
    - name: nice {{ mariadb_backup.bin }} monthly
    {% else %}
    - name: {{ mariadb_backup.bin }} monthly
    {% endif %}
    - identifier: mariadb-backup monthly backup
    - user: root
    - hour: random
    - minute: random
    - daymonth: random
{% else %}
include:
  - .remove_monthly_cronjob
{% endif %}

{% else %}

include:
  - .remove_daily_cronjob
  - .remove_monthly_cronjob

{% endif %}
