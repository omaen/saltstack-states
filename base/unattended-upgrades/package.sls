unattended-upgrades:
  pkg.installed:
    - pkgs:
      - unattended-upgrades
      - apt-listchanges
