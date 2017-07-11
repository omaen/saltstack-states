bind9:
  pkg.installed:
    - name: bind9
  service.running:
    - require:
      - pkg: bind9
