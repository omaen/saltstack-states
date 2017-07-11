{% from 'autofs/map.jinja' import autofs with context %}

autofs:
  pkg.installed:
    - name: {{ autofs.autofs }}
  service.running:
    - name: {{ autofs.service }}
    - require:
      - pkg: autofs
