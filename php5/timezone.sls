include:
  - php5
  - apache2

php_timezone:
  file.managed:
    - name: /etc/php5/apache2/conf.d/99-timezone.ini
    - source: salt://php5/files/99-timezone.ini
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php5
      - pkg: apache2
    - watch_in:
      - service: apache2
