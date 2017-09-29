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

reload_systemd_config:
  cmd.wait:
    - name: systemctl daemon-reload

mariadb-backup_service:
  file.managed:
    - name: /etc/systemd/system/mariadb-backup@.service
    - source: salt://mariadb-backup/files/mariadb-backup@.service
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: reload_systemd_config

mariadb-backup_timer:
  file.managed:
    - name: /etc/systemd/system/mariadb-backup@.timer
    - source: salt://mariadb-backup/files/mariadb-backup@.timer
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: reload_systemd_config

{% for interval in ['daily', 'monthly'] %}

mariadb-backup_{{ interval }}_timer:
  service.running:
    - name: mariadb-backup@{{ interval }}.timer
    - enable: True
    - require:
      - file: mariadb-backup_service
      - file: mariadb-backup_timer

{% endfor %}
