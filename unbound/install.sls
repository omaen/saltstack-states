{% from 'unbound/map.jinja' import unbound with context %}

unbound:
  pkg.installed:
    - name: {{ unbound.package }}
  service.running:
    - name: {{ unbound.service }}
    - require:
      - pkg: unbound
