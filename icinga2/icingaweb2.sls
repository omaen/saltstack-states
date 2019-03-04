{% from 'icinga2/map.jinja' import icinga2 with context %}

include:
  - .ido-pgsql
  - .api
  - php.fpm
{% if icinga2.use_backports %}
  - apt.repo-backports
{% endif %}

icingaweb2-apache2:
  pkg.installed:
    - name: {{ icinga2.apache2.pkg }}
  service.running:
    - name: {{ icinga2.apache2.service }}
    - reload: True
    - enable: True
    - require:
      - pkg: icingaweb2-apache2

icingaweb2-apache2-php-fpm-enable:
  cmd.run:
    - name: a2enconf {{ icinga2.apache2.conf_names.php_fpm }}
    - unless: test -f /etc/apache2/conf-enabled/{{ icinga2.apache2.conf_names.php_fpm }}.conf
    - require:
      - pkg: icingaweb2-apache2
      - pkg: php-fpm
    - watch_in:
      - service: icingaweb2-apache2

icingaweb2-apache2-proxy-fcgi-enable:
  cmd.run:
    - name: a2enmod {{ icinga2.apache2.modules.proxy_fcgi }}
    - unless: test -f /etc/apache2/mods-enabled/{{ icinga2.apache2.modules.proxy_fcgi }}.load
    - require:
      - pkg: icingaweb2-apache2
    - watch_in:
      - service: icingaweb2-apache2

icingaweb2:
  pkg.installed:
    - pkgs:
      - {{ icinga2.icingaweb2.pkgs.icingaweb2 }}
      - {{ icinga2.icingaweb2.pkgs.icingacli }}
{% if icinga2.use_backports %}
    - fromrepo: {{ grains['oscodename']|lower }}-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
    - require:
      - pkg: icinga2-ido-pgsql
      - pkg: icingaweb2-apache2
      - cmd: icinga2-api-enabled
