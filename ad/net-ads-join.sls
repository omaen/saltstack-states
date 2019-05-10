{% from 'ad/map.jinja' import ad with context %}

include:
  - krb5
  - samba

keytab:
  file.managed:
    - name: {{ ad.config.user_keytab }}.base64
    - contents: {{ ad.config.user_keytab_content }}
    - user: root
    - group: root
    - mode: 600
    - prereq:
      - cmd: keytab
  cmd.run:
    - name: base64 -d {{ ad.config.user_keytab }}.base64 > {{ ad.config.user_keytab }}
    - prereq:
      - cmd: domain_join

# Hopefully this will be fixed in later releases of Debian
samba-private-dir:
  file.directory:
    - name: /var/lib/samba/private
    - user: root
    - group: root
    - mode: 755

domain_join:
  pkg.installed:
    - name: samba-dsdb-modules
  cmd.script:
    - name: net-ads-join
    - source: salt://ad/files/net-ads-join.sh
    - template: jinja
    - unless: '[ -f /etc/krb5.keytab ] && net ads testjoin < /dev/null'
    - context:
        config: {{ ad.config|tojson }}
    - require:
      - file: smb_conf
      - file: samba-private-dir
      - pkg: krb5-user
      - pkg: domain_join
    - require_in:
      - file: krb5_keytab

# Execute these last but do not require anything to handle both failure and success
keytab_base64_removed:
  file.absent:
    - name: {{ ad.config.user_keytab }}.base64

keytab_removed:
  file.absent:
    - name: {{ ad.config.user_keytab }}

