{% from 'samba/map.jinja' import samba with context %}

samba:
{% if samba.config.get('shares', []) %}
  pkg.installed:
    - name: samba
  service.running:
    - name: smbd
    - require:
      - pkg: samba
    - watch:
      - file: smb_conf

winbind:
  {% if samba.config.get('global', {}).get('security') == 'ads' %}
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
  {% else %}
  pkg.purged:
    - name: winbind
  {% endif %}
{% else %}
  pkg.purged:
    - pkgs:
      - winbind
      - samba
{% endif %}

{% if samba.config.get('disable_netbios', False) %}
nmbd:
  service.dead:
    - name: nmbd
    - enable: False
{% endif %}
