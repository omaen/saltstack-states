php-fpm:
  pkg.installed:
    - name: php5-fpm
  service.running:
    - name: php5-fpm
    - require:
      - pkg: php-fpm

php-timezone:
  file.managed:
    - name: /etc/php5/fpm/conf.d/30-timezone.ini
    - source: salt://php-fpm/files/30-timezone.ini
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php-fpm
    - watch_in:
      - service: php-fpm

php-upload:
  file.managed:
    - name: /etc/php5/fpm/conf.d/30-upload.ini
    - source: salt://php-fpm/files/30-upload.ini
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php-fpm
    - watch_in:
      - service: php-fpm
