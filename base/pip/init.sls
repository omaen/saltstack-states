pip:
  pkg.installed:
    - name: python-pip
  pip.installed:
    - name: pip == 8.1.1
    #- upgrade: True
    - require:
      - pkg: pip
