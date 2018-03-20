{% from 'ad/map.jinja' import ad with context %}

include:
  - krb5
  - krb5.keytab-group
  - samba

keytab_base64:
  file.managed:
    - name: {{ ad.config.user_keytab }}.base64
    - contents: {{ ad.config.user_keytab_content }}
    - user: root
    - group: root
    - mode: 600
    - prereq:
      - cmd: domain_joined

keytab:
  cmd.run:
    - name: base64 -d {{ ad.config.user_keytab }}.base64 > {{ ad.config.user_keytab }}
    - require:
      - file: keytab_base64
    - prereq:
      - file: keytab_base64

# Hopefully this will be fixed in later releases of Debian
samba-private-dir:
  file.directory:
    - name: /var/lib/samba/private
    - user: root
    - group: root
    - mode: 755

domain_joined:
  pkg.installed:
    - name: samba-dsdb-modules
  cmd.script:
    - name: join-domain.sh
    - source: salt://sssd/files/join-domain.sh
    - template: jinja
    - unless: net ads testjoin < /dev/null
    - context:
        config: {{ ad.config }}
    - require:
      - file: smb_conf
      - file: samba-private-dir
      - pkg: krb5-user
      - pkg: domain_joined
    - require_in:
      - file: keytab_removed
      - file: keytab_base64_removed

keytab_removed:
  file.absent:
    - name: {{ ad.config.user_keytab }}

keytab_base64_removed:
  file.absent:
    - name: {{ ad.config.user_keytab }}.base64
