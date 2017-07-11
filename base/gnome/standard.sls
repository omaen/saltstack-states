include:
  - gnome
  - gnome.update-schema
  - chrome.domain_policy

standard:
  pkg.installed:
    - pkgs:
      - file-roller
      - freerdp-x11
      - libreoffice
      - gimp
      - vlc
      - icedove
      - gedit
      - chromium
      - libnss3-tools
    - require:
      - pkg: gnome-core

default-favorites:
  file.managed:
    - name: /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override
    - source: salt://gnome/files/org.gnome.shell.gschema.override
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: standard
    - watch_in:
      - cmd: update-schema

default-terminal-settings:
  file.managed:
    - name: /usr/share/glib-2.0/schemas/org.gnome.Terminal.gschema.override
    - source: salt://gnome/files/org.gnome.Terminal.gschema.override
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: standard
    - watch_in:
      - cmd: update-schema
