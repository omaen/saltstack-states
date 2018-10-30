ddclient:
  pkg.installed:
    - pks:
      - ddclient
      # Needed for cloudflare protocol
      - libjson-any-perl
  service.running:
    - name: ddclient
    - require:
      - pkg: ddclient
      - file: ddclient_conf
