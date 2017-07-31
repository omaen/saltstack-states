{% for namespace in salt['pillar.get']('fwgen:namespaces', {}) %}
fwgen_config_{{ namespace }}:
  file.managed:
    - name: /etc/netns/{{ namespace }}/fwgen/config.yml
    - contents_pillar: fwgen:namespaces:{{ namespace }}:config
    - makedirs: True
    - user: root
    - group: root
    - mode: 600
  cmd.wait:
    - name: ip netns exec {{ namespace }} /usr/local/bin/fwgen --no-confirm
    - watch:
      - pip: fwgen
      - file: fwgen_config_{{ namespace }}
    - require:
      - pip: fwgen
      - file: fwgen_config_{{ namespace }}
{% endfor %}

{% if not salt['pillar.get']('fwgen:no_default_firewall', False) %}
fwgen_config:
  file.managed:
    - name: /etc/fwgen/config.yml
    - contents_pillar: fwgen:config
    - makedirs: True
    - user: root
    - group: root
    - mode: 600
  cmd.wait:
    - name: /usr/local/bin/fwgen --no-confirm
    - watch:
      - pip: fwgen
      - file: fwgen_config
    - require:
      - pip: fwgen
      - file: fwgen_config
{% endif %}
