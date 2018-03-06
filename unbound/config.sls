{% from 'unbound/map.jinja' import unbound with context %}

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
