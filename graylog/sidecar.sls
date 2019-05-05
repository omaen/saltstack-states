{%- from tpldir ~ "/map.jinja" import graylog with context %}
{%- set sidecar = graylog.sidecar %}

graylog-sidecar:
  pkg.installed:
    - sources:
      - {{ sidecar.package }}: {{ sidecar.package_url }}
  cmd.run:
    - name: graylog-sidecar -service install
    - unless: systemctl is-enabled {{ sidecar.service }}
  service.running:
    - name: {{ sidecar.service }}
    - enable: True
    - require:
      - cmd: graylog-sidecar

{% if sidecar.config %}
sidecar_yml:
  file.managed:
    - name: {{ sidecar.sidecar_yml }}
    - source: salt://graylog/files/sidecar.yml.tmpl
    - template: jinja
    - user: root
    - group: root
    - mode: 664
    - context:
        config: {{ sidecar.config|tojson }}
    - require:
      - pkg: graylog-sidecar
    - watch_in:
      - service: graylog-sidecar
{% endif %}
