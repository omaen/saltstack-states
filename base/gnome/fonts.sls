fonts_conf:
  pkg.installed:
    - pkgs:
      - fonts-cantarell
      - fonts-liberation
  file.managed:
    - name: /etc/fonts/local.conf
    - source: salt://gnome/files/local.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: gnome-core
