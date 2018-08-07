{% from 'dhcp-helper/map.jinja' import dhcp_helper with context %}

dhcp_helper_config:
  file.managed:
    - name: {{ dhcp_helper.config_file }}
    - source: salt://dhcp-helper/files/dhcp-helper
    - template: jinja
    - context:
        config: {{ dhcp_helper.config }}
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: dhcp_helper

# Workaround for dhcrelay not resuming operation on an interface if idown/ifup is
# done after boot
dhcp_helper_ifup:
  file.managed:
    - name: {{ dhcp_helper.ifup }}
    - source: salt://dhcp-helper/files/ifup
    - template: jinja
    - context:
        config: {{ dhcp_helper }}
    - user: root
    - group: root
    - mode: 755
    - require:
      - service: dhcp_helper
