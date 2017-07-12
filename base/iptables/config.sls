{% for namespace in salt['pillar.get']('firewall:namespaces', {}) %}
iptables_rules_{{ namespace }}:
  file.managed:
    - name: /usr/local/bin/iptables-gen.{{ namespace }}
    - contents_pillar: firewall:namespaces:{{ namespace }}:rules
    - user: root
    - group: root
    - mode: 700
    - require:
      - file: iptables-gen-common
  cmd.wait:
    - name: ip netns exec {{ namespace }} /usr/local/bin/iptables-gen.{{ namespace }} --no-confirm
    - watch:
      - file: iptables_rules_{{ namespace }}
      - file: iptables-gen-common
    - require:
      - file: iptables_rules_{{ namespace }}
{% endfor %}

{% if not salt['pillar.get']('firewall:no_default_firewall', False) %}
iptables_rules:
  file.managed:
    - name: /usr/local/bin/iptables-gen
    - contents_pillar: firewall:rules
    - user: root
    - group: root
    - mode: 700
    - require:
      - file: iptables-gen-common
  cmd.wait:
    - name: /usr/local/bin/iptables-gen --no-confirm
    - watch:
      - file: iptables_rules
      - file: iptables-gen-common
    - require:
      - file: iptables_rules
{% endif %}
