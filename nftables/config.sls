{%- from tpldir ~ "/map.jinja" import nftables with context %}

include:
  - .install

nftables-include-dir:
  file.directory:
    - name: {{ nftables.include_dir }}
    - user: root
    - group: root
    - dir_mode: 750
    - clean: True

{% for include in nftables.include %}
nftables-include-{{ include }}:
  file.managed:
    - name: {{ nftables.include_dir }}/{{ include }}.ruleset
    - contents_pillar: nftables:include:{{ include }}
    - mode: 640
    - user: root
    - group: root
    # Needed to make clean in nftables-include-dir work as intended without recursive requirement issues.
    # See https://github.com/saltstack/salt/issues/12965
    - makedirs: True
    - require_in:
      - file: nftables-include-dir
      - file: nftables-config
{% endfor %}

nftables-config:
  file.managed:
    - name: {{ nftables.config }}
    - source: salt://nftables/files/etc/nftables.conf.tmpl
    - mode: 640
    - user: root
    - group: root
    - template: jinja
    - context:
        include_dir: {{ nftables.include_dir }}
        ruleset: {{ nftables.ruleset|yaml(False) }}
