{% from 'apache2/map.jinja' import apache2 with context %}

include:
  - .package
  - php

{% set timezone = salt.cmd.run('cat /etc/timezone') %}

apache2-php-timezone:
  file.managed:
    - name: {{ apache2.php_conf_path }}/conf.d/99-timezone.ini
    - contents: |
        date.timezone = '{{ timezone }}'
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: php
      - pkg: apache2
    - watch_in:
      - service: apache2
