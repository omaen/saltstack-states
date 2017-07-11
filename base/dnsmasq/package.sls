include:
  - resolvconf

dnsmasq:
  pkg.installed:
    - name: dnsmasq
    - require:
      - service: resolvconf
  service.running:
    - name: dnsmasq
    - require:
      - pkg: dnsmasq
