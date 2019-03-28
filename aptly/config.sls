{%- from tpldir ~ "/map.jinja" import aptly with context %}

include:
  - .install

aptly-user:
  user.present:
    - name: aptly
    - system: True
    - shell: /usr/sbin/nologin
    - createhome: False
    - home: /srv/aptly
