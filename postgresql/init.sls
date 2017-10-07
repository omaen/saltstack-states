postgresql:
  pkg.installed:
    - name: postgresql
  service.running:
    - name: postgresql
    - require:
      - pkg: postgresql
