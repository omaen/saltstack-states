ddclient:
  pkg.installed:
    - name: ddclient
  service.running:
    - name: ddclient
    - require:
      - pkg: ddclient
      - file: ddclient_conf
