{% from 'conntrackd/map.jinja' import conntrackd with context %}

conntrackd:
  pkg.installed:
    - name: {{ conntrackd.package }}
  service.running:
    - name: {{ conntrackd.service }}
