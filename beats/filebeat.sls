{%- from tpldir ~ "/map.jinja" import beats with context %}
{% set filebeat = beats.filebeat %}

include:
  - elastic.repo

filebeat:
  pkg.installed:
    - name: {{ filebeat.package }}
    {% if filebeat.version %}
    - version: {{ filebeat.version }}
    {% endif %}
    - hold: True
    - require:
      - pkgrepo: elastic-repo
{% if filebeat.disable_service %}
  service.dead:
    - name: {{ filebeat.service }}
    - enable: False
{% else %}
  service.running:
    - name: {{ filebeat.service }}
    - enable: True
{% endif %}
    - require:
      - pkg: filebeat

{% if filebeat.config %}
filebeat_yml:
  file.managed:
    - name: {{ filebeat.filebeat_yml }}
    - source: salt://beats/files/beats.yml.tmpl
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - context:
        config: {{ filebeat.config|tojson }}
    - watch_in:
      - service: filebeat
    - require:
      - pkg: filebeat
{% endif %}
