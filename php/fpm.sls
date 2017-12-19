{% from 'php/map.jinja' import php with context %}

include:
  - .modules

php-fpm:
  pkg.installed:
    - name: {{ php.fpm.package }}
  service.running:
    - name: {{ php.fpm.service }}
    - require:
      - pkg: php-fpm
    {% if php.config.modules %}
    - watch:
      {% for module in php.config.modules %}
      - pkg: php-{{ module }}
      {% endfor %}
    {% endif %}

php-fpm-config:
  file.managed:
    - name: {{ php.fpm.confdir }}/conf.d/99-salt.ini
    - source: salt://php/files/99-salt.ini
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ php.fpm.config }}
    - watch_in:
      - service: php-fpm
