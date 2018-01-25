{% from 'dnsmasq/map.jinja' import dnsmasq with context %}

dnsmasq:
  pkg.installed:
    - name: {{ dnsmasq.package }}
  service.running:
    - name: {{ dnsmasq.service }}
    - require:
      - pkg: dnsmasq
