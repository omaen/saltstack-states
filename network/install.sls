resolvconf:
  pkg.installed:
    - name: resolvconf
  service.running:
    - name: resolvconf
    - require:
      - pkg: resolvconf

rdnssd:
  pkg.installed:
    - name: rdnssd
  service.running:
    - name: rdnssd
    - require:
      - pkg: rdnssd
