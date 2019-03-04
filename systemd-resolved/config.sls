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

resolv.conf:
  file.managed:
    - name: /etc/resolv.conf
    - contents: |
        # This is a static resolv.conf file for connecting local clients to
        # systemd-resolved via its DNS stub listener on 127.0.0.53.
        nameserver 127.0.0.53
    - user: root
    - group: root
    - follow_symlinks: false

{%- if systemd_resolved.disable_dhclient_updates %}
/etc/dhcp/dhclient-enter-hooks.d/nodnsupdate:
  file.managed:
    - contents: |
        #!/bin/sh
        make_resolv_conf() {
            :
        }
    - user: root
    - group: root
    - mode: 755
{%- else %}
/etc/dhcp/dhclient-enter-hooks.d/nodnsupdate:
  file.absent

# As dhclient will interfere ensure the stub resolver is put first.
# resolv.conf update could be disabled completely for dhclient but
# this could be somewhat dangerous if systemd-resolved have no other
# valid DNS servers available
dhclient.conf:
  file.replace:
    - name: /etc/dhcp/dhclient.conf
    - pattern: ^.*prepend domain-name-servers.*$
    - repl: prepend domain-name-servers 127.0.0.53;
    - append_if_not_found: true
    - ignore_if_missing: true
{%- endif %}
