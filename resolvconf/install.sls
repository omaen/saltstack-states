resolvconf:
  pkg.installed:
    - name: resolvconf
  service.running:
    - name: resolvconf
    - require:
      - pkg: resolvconf
