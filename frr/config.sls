{% from 'frr/map.jinja' import frr with context %}

{% for daemon in frr.daemons %}
frr_daemon_{{ daemon }}:
  file.line:
    - name: /etc/frr/daemons
    - content: {{ daemon }}=yes
    - match: {{ daemon }}=
    - mode: replace
    - watch_in:
      - service: frr
{% endfor %}

frr.conf:
  file.managed:
    - name: /etc/frr/frr.conf
    - source: salt://frr/files/frr.conf
    - template: jinja
    - user: frr
    - group: frr
    - mode: 640
    - context:
       config: {{ frr.config|tojson }}
    - watch_in:
      - service: frr
