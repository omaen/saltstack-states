include:
  - krb5.keytab-group

domain_join_keytab_base64:
  file.managed:
    - name: {{ salt['pillar.get']('ad:domain_join_keytab') }}.base64
    - contents_pillar: keytabs:{{ salt['pillar.get']('ad:domain_join_user') }}
    - user: root
    - group: root
    - mode: 600
    - prereq:
      - cmd: domain_join_keytab

domain_join_keytab:
  cmd.run:
    - name: base64 -d {{ salt['pillar.get']('ad:domain_join_keytab') }}.base64 > {{ salt['pillar.get']('ad:domain_join_keytab') }}
    - prereq:
      - cmd: net-ads-join
  file.absent:
    - name: {{ salt['pillar.get']('ad:domain_join_keytab') }}.base64
    - require:
      - cmd: domain_join_keytab

remove_domain_join_keytab:
  file.absent:
    - name: {{ salt['pillar.get']('ad:domain_join_keytab') }}

# Hopefully this will be fixed in later releases of Debian
samba-private-dir:
  file.directory:
    - name: /var/lib/samba/private
    - user: root
    - group: root
    - mode: 755

net-ads-join:
  cmd.script:
    - name: join-domain.sh
    - source: salt://sssd/files/join-domain.sh
    - template: jinja
    - unless: net ads testjoin < /dev/null
    - require:
      - file: samba_conf
      - file: samba-private-dir
      - pkg: krb5-user
    - watch_in:
      - file: krb5_keytab
    - require_in:
      - file: remove_domain_join_keytab
