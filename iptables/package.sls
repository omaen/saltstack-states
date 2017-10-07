restore-fw:
  pkg.installed:
    - name: ipset
  file.managed:
    - name: /usr/local/bin/restore-fw
    - source: salt://iptables/files/restore-fw
    - user: root
    - group: root
    - mode: 755

restore-fw-ifupdown:
  file.symlink:
    - name: /etc/network/if-pre-up.d/restore-fw
    - target: /usr/local/bin/restore-fw
    - force: True
    - require:
      - file: restore-fw

iptables-gen-common:
  pkg.installed:
    - pkgs:
      - conntrack
      - ipset
  file.managed:
    - name: /usr/local/lib/iptables-gen/common
    - source: salt://iptables/files/common
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require:
      - pkg: iptables-gen-common
