{% from 'systemd-resolved/map.jinja' import systemd_resolved with context %}

systemd_resolved:
  pkg.installed:
    - name: {{ systemd_resolved.libnss_package }}
  cmd.run:
    - name: ldconfig
    - onchanges:
      - pkg: systemd_resolved
  service.running:
    - name: {{ systemd_resolved.service }}
    - enable: True
    - require:
      - pkg: systemd_resolved
