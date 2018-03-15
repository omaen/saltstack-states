{% from 'sssd/map.jinja' import sssd with context %}

include:
  - .config
  - .mkhomedir
  - .join-domain

sssd-ad:
  pkg.installed:
    - pkgs:
      - {{ sssd.packages['sssd-ad'] }}
      - {{ sssd.packages['libnss-sss'] }}
      - {{ sssd.packages['libpam-sss'] }}
      - {{ sssd.packages['sssd-tools'] }}
  service.running:
    - name: {{ sssd.service }}
    - require:
      - pkg: sssd-ad
      - file: sssd_conf
      - cmd: net-ads-join
    - watch:
      - file: sssd_conf
