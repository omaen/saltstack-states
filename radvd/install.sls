{% from 'radvd/map.jinja' import radvd with context %}

radvd:
  pkg.installed:
    - name: {{ radvd.package }}
