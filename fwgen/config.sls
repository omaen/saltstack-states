include:
  - iptables.remove

{% from 'fwgen/map.jinja' import fwgen with context %}
{% for namespace in fwgen.namespaces %}
fwgen_config_{{ namespace }}:
  file.managed:
    - name: /etc/netns/{{ namespace }}/fwgen/config.yml
    - contents_pillar: fwgen:namespaces:{{ namespace }}:config
    - makedirs: True
    - user: root
    - group: root
    - mode: 600
  cmd.wait:
    - name: ip netns exec {{ namespace }} fwgen --no-confirm
    - watch:
      - pip: fwgen
      - file: fwgen_config_{{ namespace }}
    - require:
      - pip: fwgen
      - file: fwgen_config_{{ namespace }}
    - require_in:
      - file: iptables-gen_remove
{% endfor %}

{% if not fwgen.no_default_firewall %}
fwgen_config:
  file.managed:
    - name: /etc/fwgen/config.yml
    - contents_pillar: fwgen:config
    - makedirs: True
    - user: root
    - group: root
    - mode: 600
  cmd.wait:
    - name: fwgen --no-confirm
    - watch:
      - pip: fwgen
      - file: fwgen_config
    - require:
      - pip: fwgen
      - file: fwgen_config
    - require_in:
      - file: iptables-gen_remove
{% endif %}
