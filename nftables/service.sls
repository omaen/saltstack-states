{%- from tpldir ~ "/map.jinja" import nftables with context %}

include:
  - .config

nftables-service:
  service.running:
    - name: {{ nftables.service.name }}
    - enable: True
    - reload: True
    - watch:
      - file: nftables-config
{% for include in nftables.include %}
      - file: nftables-include-{{ include }}
{% endfor %}
