restore-fw:
  pkg.installed:
    - name: ipset
  file.managed:
    - name: /usr/local/bin/restore-fw
    - source: salt://fwgen/files/restore-fw.sh
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: restore-fw

restore-fw-ifupdown:
  file.symlink:
    - name: /etc/network/if-pre-up.d/restore-fw
    - target: /usr/local/bin/restore-fw
    - force: True
    - require:
      - file: restore-fw

fwgen:
  pkg.installed:
    - pkgs:
      - ipset
      - python3-yaml
  file.managed:
    - name: /usr/local/bin/fwgen
    - source: salt://fwgen/files/fwgen.py
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - require:
      - pkg: fwgen
