{% from 'isc-dhcp-relay/map.jinja' import dhcp_relay with context %}

dhcp_relay:
  pkg.installed:
    - name: {{ dhcp_relay.package }}
  service.running:
    - name: {{ dhcp_relay.service }}
    - require:
      - pkg: dhcp_relay
