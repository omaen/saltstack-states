{% from 'samba/map.jinja' import samba with context %}

samba_conf:
  file.managed:
    - name: {{ samba.config_file }}
    - source: salt://samba/files/smb.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ samba.config }}
{% if samba.config.get('shares', []) %}
{% if salt['pillar.get']('roles:domain-member') %}
    - require:
      - pkg: samba
      - pkg: winbind
    - watch_in:
      - service: samba
      - service: winbind
{% else %}
    - require:
      - pkg: samba
    - watch_in:
      - service: samba
{% endif %}
{% else %}
    - require:
      - pkg: samba-common
{% endif %}
