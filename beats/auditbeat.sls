{%- from tpldir ~ "/map.jinja" import beats with context %}
{% set auditbeat = beats.auditbeat %}

include:
  - elastic.repo

auditbeat:
  pkg.installed:
    - name: {{ auditbeat.package }}
    {% if auditbeat.version %}
    - version: {{ auditbeat.version }}
    {% endif %}
    - hold: True
    - require:
      - pkgrepo: elastic-repo
{% if auditbeat.disable_service %}
  service.dead:
    - name: {{ auditbeat.service }}
    - enable: False
{% else %}
  service.running:
    - name: {{ auditbeat.service }}
    - enable: True
{% endif %}
    - require:
      - pkg: auditbeat

{% if auditbeat.config %}
auditbeat_yml:
  file.managed:
    - name: {{ auditbeat.auditbeat_yml }}
    - source: salt://beats/files/beats.yml.tmpl
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - context:
        config: {{ auditbeat.config|tojson }}
    - watch_in:
      - service: auditbeat
    - require:
      - pkg: auditbeat
{% endif %}
