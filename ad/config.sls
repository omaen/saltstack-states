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
      - cmd: domain_joined

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
    - source: salt://ad/files/join-domain.sh
    - template: jinja
    # Do not use "net ads testjoin" here, as it will also fail during intermittent
    # errors in the network and DNS, causing unnecessary rejoins
    - unless: test -f /etc/krb5.keytab
    - context:
        config: {{ ad.config }}
    - require:
      - file: smb_conf
      - file: samba-private-dir
      - pkg: krb5-user
      - pkg: domain_joined
    - require_in:
      - file: krb5_keytab

# Execute these last but do not require anything to handle both failure and success
keytab_base64_removed:
  file.absent:
    - name: {{ ad.config.user_keytab }}.base64

keytab_removed:
  file.absent:
    - name: {{ ad.config.user_keytab }}

