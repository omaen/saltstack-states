{% from 'ddclient/map.jinja' import ddclient with context %}

ddclient:
  pkg.installed:
    - pks:
      - {{ ddclient.package }}
      # Needed for cloudflare protocol
      - libjson-any-perl
      - libdata-validate-ip-perl
  service.running:
    - name: {{ ddclient.service }}
    - require:
      - pkg: ddclient
      - file: ddclient_conf
