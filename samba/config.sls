{% from 'samba/map.jinja' import samba with context %}

samba-common:
  pkg.installed:
    - name: samba-common-bin

smb_conf:
  file.managed:
    - name: {{ samba.config_file }}
    - source: salt://samba/files/smb.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ samba.config }}
    - require:
      - pkg: samba-common
