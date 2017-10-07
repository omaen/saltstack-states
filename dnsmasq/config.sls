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
        config: {{ dnsmasq.config }}
    - watch_in:
      - service: dnsmasq
    - require:
      - pkg: dnsmasq
