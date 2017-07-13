{% from 'mariadb-backup/map.jinja' import mariadb_backup with context %}

# It seems like you only have to satisfy a grep-like match on "name", i.e., you can match on
# part of the command in the crontab, as long as the "identifier" also matches the existing cron job.
# It does not seem to work with only one of name or identifier as long as both are in the crontab.
mariadb-backup_cron_monthly_remove:
  cron.absent:
    - name: {{ mariadb_backup.bin }} monthly
    - identifier: mariadb-backup monthly backup
    - user: root
