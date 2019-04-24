{% from 'dnsmasq/map.jinja' import dnsmasq with context %}

dnsmasq-config:
  file.managed:
    - name: {{ dnsmasq.config_file }}
    - source: salt://dnsmasq/files/dnsmasq.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        # filter via json to preserve None as actual None, not string
        config: {{ dnsmasq.config|tojson }}
    - watch_in:
      - service: dnsmasq
    - require:
      - pkg: dnsmasq
