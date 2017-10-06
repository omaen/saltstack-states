{% from 'icinga2-update/map.jinja' import icinga2_update with context %}

icinga2-update_bin:
  pkg.installed:
    - pkgs:
      - python3-requests
      - python3-yaml
  file.managed:
    - name: {{ icinga2_update.bin }}
    - source: salt://icinga2-update/files/icinga2-update
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
