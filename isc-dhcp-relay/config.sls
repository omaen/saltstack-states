{% from 'isc-dhcp-relay/map.jinja' import dhcp_relay with context %}

dhcp_relay_config:
  file.managed:
    - name: {{ dhcp_relay.config_file }}
    - source: salt://isc-dhcp-relay/files/isc-dhcp-relay
    - template: jinja
    - context:
        config: {{ dhcp_relay.config }}
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: dhcp_relay
