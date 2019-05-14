{%- from tpldir ~ "/map.jinja" import graylog with context %}

include:
  - .install

{% for k, v in graylog.config.items() %}
'graylog-server.conf: {{ k }}':
  file.replace:
    - name: {{ graylog.server_conf }}
    - pattern: '^#*{{ k|regex_escape }} =.*$'
{% if v is list %}
    - repl: '{{ k }} = {{ v|join(", ") }}'
{% else %}
    - repl: '{{ k }} = {{ v }}'
{% endif %}
    - append_if_not_found: True
    - count: 1
    - watch_in:
      - service: graylog
    - require:
      - pkg: graylog
{% endfor %}
