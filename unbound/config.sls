{% from 'unbound/map.jinja' import unbound with context %}

include:
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
        config: {{ unbound.config }}
    - watch_in:
      - service: unbound

# Note that you should not configure the anycast addresses as system
# interfaces. Let the systemd unit file handle these addresses on its own.
unbound.service:
{% if unbound.anycast_addrs %}
  file.managed:
    - name: /etc/systemd/system/{{ unbound.service }}.service
    - source: salt://unbound/files/unbound.service
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ unbound.anycast_addrs }}
{% else %}
  file.absent:
    - name: /etc/systemd/system/{{ unbound.service }}.service
{% endif %}
    - watch_in:
      - cmd: daemon-reload
      - service: unbound
