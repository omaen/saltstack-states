{% from 'network/map.jinja' import network with context %}

{% if grains['os']|lower == 'debian' %}

interfaces:
  file.managed:
    - name: /etc/network/interfaces
    - source: salt://network/files/interfaces
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ network|tojson }}

{% endif %}
