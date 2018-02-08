{% from 'squid/map.jinja' import squid with context %}

squid:
  pkg.installed:
    - name: {{ squid.package }}
  service.running:
    - name: {{ squid.service }}
    - require:
      - pkg: squid
