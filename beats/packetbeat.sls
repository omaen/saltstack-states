{%- from tpldir ~ "/map.jinja" import beats with context %}
{% set packetbeat = beats.packetbeat %}

include:
  - elastic.repo

packetbeat:
  pkg.installed:
    - name: {{ packetbeat.package }}
    {% if packetbeat.version %}
    - version: {{ packetbeat.version }}
    {% endif %}
    - hold: True
    - require:
      - pkgrepo: elastic-repo
{% if packetbeat.disable_service %}
  service.dead:
    - name: {{ packetbeat.service }}
    - enable: False
{% else %}
  service.running:
    - name: {{ packetbeat.service }}
    - enable: True
{% endif %}
    - require:
      - pkg: packetbeat

{% if packetbeat.config %}
packetbeat_yml:
  file.managed:
    - name: {{ packetbeat.packetbeat_yml }}
    - source: salt://beats/files/beats.yml.tmpl
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - context:
        config: {{ packetbeat.config|tojson }}
    - watch_in:
      - service: packetbeat
    - require:
      - pkg: packetbeat
{% endif %}
