exim4:
  pkg.installed:
    - name: exim4-daemon-light
  service.running:
    - require:
      - pkg: exim4
