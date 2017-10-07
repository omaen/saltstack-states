{% from 'mariadb-backup/map.jinja' import mariadb_backup with context %}

mariadb-backup:
  file.managed:
    - name: {{ mariadb_backup.bin }}
    - source: salt://mariadb-backup/files/mariadb-backup
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
