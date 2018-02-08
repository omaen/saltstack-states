{% from 'radvd/map.jinja' import radvd with context %}

radvd:
  pkg.installed:
    - name: {{ radvd.package }}
  service.running:
    - name: {{ radvd.service }}
    - require:
      - pkg: radvd
