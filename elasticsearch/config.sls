{%- from tpldir ~ "/map.jinja" import elasticsearch with context %}

include:
  - .install
  - systemctl.daemon-reload

/etc/systemd/system/{{ elasticsearch.service }}.service.d/override.conf:
{% if salt.pillar.get('elasticsearch:service_config') %}
  file.managed:
    - source: salt://systemd/files/service.tmpl
    - template: jinja
    - makedirs: True
    - mode: 644
    - user: root
    - group: root
    - context:
        config: {{ elasticsearch.service_config|tojson }}
{% else %}
  file.absent:
{% endif %}
    - watch_in:
      - cmd: daemon-reload
      - service: elasticsearch

{% for k, v in elasticsearch.config.items() %}
'elasticsearch.yml: {{ k }}':
  file.replace:
    - name: {{ elasticsearch.elasticsearch_yml }}
    - pattern: '^#*{{ k|regex_escape }}:.*$'
{% if v is list %}
    - repl: '{{ k }}: [{{ v|join(", ") }}]'
{% else %}
    - repl: '{{ k }}: {{ v }}'
{% endif %}
    - append_if_not_found: True
    - count: 1
    - watch_in:
      - service: elasticsearch
    - require:
      - pkg: elasticsearch
{% endfor %}

{% for k, v in elasticsearch.environment.items() %}
'elasticsearch-environment: {{ k }}':
  file.line:
    - name: /etc/default/elasticsearch
    - mode: replace
    - match: '{{ k }}='
    - content: '{{ k }}={{ v }}'
    - watch_in:
      - service: elasticsearch
    - require:
      - pkg: elasticsearch
{% endfor %}

{% for k, v in elasticsearch.jvm_options.items() %}
'jvm.options: {{ k }}':
  file.line:
    - name: {{ elasticsearch.jvm_options_file }}
    - mode: replace
    - match: ^{{ k }}
    - content: {{ k }}{{ v }}
    - watch_in:
      - service: elasticsearch
    - require:
      - pkg: elasticsearch
{% endfor %}

{% if elasticsearch.config['path.data'] is defined %}
elasticsearch-data:
  file.directory:
    - name: {{ elasticsearch.config['path.data'] }}
    - user: {{ elasticsearch.user }}
    - group: {{ elasticsearch.group }}
    - mode: 755
    - require:
      - pkg: elasticsearch
    - require_in:
      - service: elasticsearch
{% endif %}
