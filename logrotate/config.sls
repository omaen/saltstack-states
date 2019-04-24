{% from 'logrotate/map.jinja' import logrotate with context %}

{% for config, params in logrotate.configs.items() %}

{% if params %}
logrotate_{{ config }}:
  file.managed:
    - name: {{ logrotate.config_dir }}/{{ config }}
    - source: salt://logrotate/files/template.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ params|tojson }}
{% else %}
logrotate_{{ config }}_removed:
  file.absent:
    - name: {{ logrotate.config_dir }}/{{ config }}
{% endif %}

{% endfor %}
