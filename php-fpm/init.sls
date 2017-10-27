{% from 'php-fpm/map.jinja' import php_fpm with context %}

php-fpm:
  pkg.installed:
    - name: {{ php_fpm.package }}
  service.running:
    - name: {{ php_fpm.service }}
    - require:
      - pkg: php-fpm

{% set timezone = salt.cmd.run('cat /etc/timezone') %}

php-fpm-timezone:
  file.managed:
    - name: {{ php_fpm.php_conf_path }}/conf.d/99-timezone.ini
    - contents: |
        date.timezone = '{{ timezone }}'
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php-fpm
    - watch_in:
      - service: php-fpm

php-fpm-upload:
  file.managed:
    - name: {{ php_fpm.php_conf_path }}/conf.d/99-upload.ini
    - source: salt://php-fpm/files/30-upload.ini
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php-fpm
    - watch_in:
      - service: php-fpm
