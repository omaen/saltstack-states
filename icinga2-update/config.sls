{% from 'icinga2-update/map.jinja' import icinga2_update with context %}

{% if icinga2_update.config %}

icinga2-update_config:
  file.managed:
    - name: {{ icinga2_update.config_file }}
    - source: salt://icinga2-update/files/config.yml
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - makedirs: True
    - context:
        config: {{ icinga2_update.config|tojson }}
{% else %}

remove_icinga2-update_config:
  file.absent:
    - name: {{ icinga2_update.config_file }}

{% endif %}
