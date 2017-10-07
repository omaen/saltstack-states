{% from 'ntp/map.jinja' import ntp with context %}

ntp:
  pkg.installed:
    - name: {{ ntp.package }}
  service.running:
    - name: {{ ntp.service }}
    - require:
      - pkg: ntp
