{% from 'borgwrapper/map.jinja' import borgwrapper with context %}

include:
  - borgbackup.package

borgwrapper_bin:
  file.managed:
    - name: {{ borgwrapper.bin }}
    - source: salt://borgwrapper/files/borgwrapper.sh
    - user: root
    - group: root
    - mode: 750
    - makedirs: True
    - require:
      - pkg: borgbackup
