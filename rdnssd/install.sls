rdnssd:
  pkg.installed:
    - name: rdnssd
  service.running:
    - name: rdnssd
    - require:
      - pkg: rdnssd
