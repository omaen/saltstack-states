{% from 'systemd-resolved/map.jinja' import systemd_resolved with context %}

resolved_conf:
  file.managed:
    - name: {{ systemd_resolved.resolved_conf }}
    - source: salt://systemd-resolved/files/resolved.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ systemd_resolved.config }}
    - watch_in:
      - service: systemd-resolved

#/etc/resolv.conf:
#  file.symlink:
#    - target: /lib/systemd/resolv.conf
