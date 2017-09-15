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

check_borgwrapper:
  file.managed:
    - name: {{ borgwrapper.nagios_plugin_dir }}/check_borgwrapper
    - source: salt://borgwrapper/files/check_borgwrapper
    - onlyif: test -d {{ borgwrapper.nagios_plugin_dir }}
    - user: root
    - group: root
    - mode: 755
