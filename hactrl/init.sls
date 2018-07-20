hactrl:
  file.managed:
    - name: /usr/local/bin/hactrl
    - source: salt://hactrl/files/hactrl
    - mode: 750
    - user: root
    - group: staff
