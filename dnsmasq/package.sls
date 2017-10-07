{% from 'dnsmasq/map.jinja' import dnsmasq with context %}

include:
  - resolvconf

dnsmasq:
  pkg.installed:
    - name: {{ dnsmasq.package }}
    - require:
      - service: resolvconf
  service.running:
    - name: {{ dnsmasq.service }}
    - require:
      - pkg: dnsmasq
