{% from 'unbound/map.jinja' import unbound with context %}

include:
  - .install
  - systemctl.daemon-reload

unbound_conf:
  file.managed:
    - name: {{ unbound.unbound_conf }}
    - source: salt://unbound/files/unbound.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ unbound.config|tojson }}
    - watch_in:
      - service: unbound

# Note that you should not configure the anycast addresses as system
# interfaces. Let the systemd unit file handle these addresses on its own.
/etc/systemd/system/{{ unbound.service }}.service.d/override.conf:
{% if unbound.anycast_addrs %}
  file.managed:
    - onlyif: systemctl is-enabled {{ unbound.service }}.service
    - source: salt://unbound/files/override.conf
    - template: jinja
    - makedirs: True
    - mode: 644
    - user: root
    - group: root
    - context:
        config: {{ unbound.anycast_addrs|tojson }}
{% else %}
  file.absent:
{% endif %}
    - watch_in:
      - cmd: daemon-reload
      - service: unbound
