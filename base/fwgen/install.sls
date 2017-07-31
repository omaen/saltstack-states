fwgen:
  pkg.installed:
    - pkgs:
      - ipset
      - python3-pip
      - python3-yaml
  pip.installed:
    - name: fwgen
    - bin_env: /usr/bin/pip3
    - require:
      - pkg: fwgen

restore-fw:
  file.symlink:
    - name: /etc/network/if-pre-up.d/restore-fw
    - target: /usr/local/lib/python3.5/dist-packages/fwgen/sbin/restore-fw
    - force: True
    - require:
      - pip: fwgen
