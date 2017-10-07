dhcp-helper:
  pkg.installed:
    - name: dhcp-helper
  service.running:
    - name: dhcp-helper
    - require:
      - pkg: dhcp-helper
      - file: dhcp-helper_default

dhcp-helper_default:
  file.managed:
    - name: /etc/default/dhcp-helper
    - source: salt://dhcp-helper/files/dhcp-helper
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: dhcp-helper
    - watch_in:
      - service: dhcp-helper
