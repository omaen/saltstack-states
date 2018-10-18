tls_config:
  file.managed:
    - name: /etc/exim4/conf.d/main/00_exim4-config_tls
    - source: salt://exim4/files/00_exim4-config_tls
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: exim4
    - require:
      - file: exim4_conf

exim4_public_cert:
  file.managed:
    - name: /etc/exim4/exim.crt
    - contents_pillar: exim4:certificate:public_cert
    - follow_symlinks: False
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: exim4
    - require:
      - pkg: exim4
    - require_in:
      - file: tls_config

exim4_private_key:
  file.managed:
    - name: /etc/exim4/exim.key
    - contents_pillar: exim4:certificate:private_key
    - follow_symlinks: False
    - user: Debian-exim
    - group: Debian-exim
    - mode: 600
    - watch_in:
      - service: exim4
    - require:
      - pkg: exim4
    - require_in:
      - file: tls_config
