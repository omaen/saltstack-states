{% from 'samba/map.jinja' import samba with context %}

{% if samba.config.get('shares', []) %}
samba:
  pkg.installed:
    - name: samba
  service.running:
    - name: smbd
    - require:
      - pkg: samba
    - watch:
      - file: smb_conf

{% if salt['pillar.get']('roles:domain-member') %}
winbind:
  pkg.installed:
    - name: winbind
    - require:
      - pkg: samba
  service.running:
    - name: winbind
    - require:
      - pkg: winbind
    - watch:
      - file: smb_conf
{% endif %}
{% endif %}

{% if samba.config.get('disable_netbios', False) %}
nmbd:
  service.dead:
    - name: nmbd
    - enable: False
{% endif %}
