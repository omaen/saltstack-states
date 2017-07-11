spf:
  pkg.installed:
    - name: spf-tools-perl
  file.managed:
    - name: /etc/exim4/conf.d/main/00_exim4-config_spf
    - source: salt://exim4/files/00_exim4-config_spf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: exim4
    - require:
      - file: exim4_conf
      - pkg: spf
