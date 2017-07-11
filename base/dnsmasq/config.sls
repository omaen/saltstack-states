dnsmasq-config:
  file.managed:
    - name: /etc/dnsmasq.conf
    - source: salt://dnsmasq/files/dnsmasq.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: dnsmasq
    - require:
      - pkg: dnsmasq
