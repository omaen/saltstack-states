isc-dhcp-server:
  pkg.installed:
    - name: isc-dhcp-server
  service.running:
    - require:
      - pkg: isc-dhcp-server
