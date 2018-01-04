{% from 'rsyslog/map.jinja' import rsyslog with context %}

{% for config, params in rsyslog.configs.items() %}

{% if params %}
rsyslog_{{ config }}:
  file.managed:
    - name: {{ rsyslog.config_dir }}/{{ config }}.conf
    - source: salt://rsyslog/files/template.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ params }}
    - watch_in:
      - service: rsyslog
{% else %}
rsyslog_{{ config }}_removed:
  file.absent:
    - name: {{ rsyslog.config_dir }}/{{ config }}.conf
    - watch_in:
      - service: rsyslog
{% endif %}

{% endfor %}
