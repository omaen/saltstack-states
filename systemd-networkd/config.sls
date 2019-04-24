{% from 'systemd-networkd/map.jinja' import systemd_networkd with context %}

systemd-networkd.service:
  service.running:
    - enable: True

{% for k, v in systemd_networkd.networks.items() %}
{{ k }}.network:
  file.managed:
    - name: /etc/systemd/network/{{ k }}.network
    - source: salt://systemd/files/service.tmpl
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - context:
        config: {{ v|tojson }}
    - watch_in:
      - service: systemd-networkd.service
{% endfor %}

{% for k, v in systemd_networkd.links.items() %}
{{ k }}.link:
  file.managed:
    - name: /etc/systemd/network/{{ k }}.link
    - source: salt://systemd/files/service.tmpl
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - context:
        config: {{ v|tojson }}
    - watch_in:
      - service: systemd-networkd.service
{% endfor %}
