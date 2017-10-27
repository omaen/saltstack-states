include:
  - apache2
  - apache2.php-timezone
  - imapproxy
  - memcached

roundcube:
  pkg.installed:
    - pkgs:
      - roundcube
      - roundcube-mysql
      - roundcube-plugins
      - php-pear
      - php5-memcache
      - php-apc
    - require:
      - pkg: apache2
      - service: memcached
      - service: imapproxy
    - watch_in:
      - service: apache2

roundcube_config:
  file.managed:
    - name: /srv/roundcube/config/config.inc.php
    - source: salt://roundcube/files/config.inc.php
    - template: jinja
    - user: root
    - group: www-data
    - mode: 640
    - require:
      - cmd: roundcube
