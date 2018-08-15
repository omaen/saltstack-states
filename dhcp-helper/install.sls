{% from 'dhcp-helper/map.jinja' import dhcp_helper with context %}

dhcp_helper:
  pkg.installed:
    - name: {{ dhcp_helper.package }}
  service.running:
    - name: {{ dhcp_helper.service }}
    - enable: True
    - require:
      - pkg: dhcp_helper
