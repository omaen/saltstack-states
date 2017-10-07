{% from 'autofs/map.jinja' import autofs with context %}

auto_master:
  file.managed:
    - name: /etc/auto.master
    - source: salt://autofs/files/auto.master
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: autofs
    - context:
      maps: {{ autofs.maps }}
    - watch_in:
      - service: autofs

{% for map_name, config in autofs.maps.iteritems() %}
auto_{{ map_name }}:
  file.managed:
    - name: /etc/auto.{{ map_name }}
    - source: salt://autofs/files/auto.template
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - require:
      - file: auto_master
    - context:
      map: {{ config.map }}
    - watch_in:
      - service: autofs
{% endfor %}
