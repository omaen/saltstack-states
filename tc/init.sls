{% if pillar['traffic_control'] is defined %}

tc-gen:
  pkg.installed:
    - name: ethtool
  file.managed:
    - name: /usr/local/bin/tc-gen
    - source: salt://tc/files/tc-gen
    - user: root
    - group: root
    - mode: 700
    - require:
      - pkg: tc-gen

{% endif %}
