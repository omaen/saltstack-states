{% from 'icinga2/map.jinja' import icinga2 with context %}

include:
  - .service

icinga2-api-setup:
  cmd.run:
    - name: icinga2 api setup
    - unless: test -f /etc/icinga2/conf.d/api-users.conf
    - require:
      - pkg: icinga2
    - watch_in:
      - service: icinga2-service-restart

icinga2-api-enabled:
  cmd.run:
    - name: icinga2 feature enable api
    - unless: test -f /etc/icinga2/features-enabled/api.conf
    - require:
      - cmd: icinga2-api-setup
    - watch_in:
      - service: icinga2-service-restart

{% if icinga2.config.api_users %}
icinga2-api-users:
  file.managed:
    - name: /etc/icinga2/conf.d/api-users.conf
    - source: salt://icinga2/files/config.conf.tmpl
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        # json is needed to avoid issue with newlines becoming literal \n in the output
        config: {{ icinga2.config.api_users|json }}
    - require:
      - cmd: icinga2-api-enabled
    - watch_in:
      - service: icinga2-service-reload
{% endif %}
