{% from 'ad/map.jinja' import ad with context %}

include:
  - krb5

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

domain_join:
  pkg.installed:
    - name: adcli
  cmd.script:
    - name: adcli-join
    - source: salt://ad/files/adcli-join.sh
    - template: jinja
    - unless: '[ -f /etc/krb5.keytab ] && kinit -k $(echo "{{ grains['host'] }}" | tr [:lower:] [:upper:])$'
    - context:
        config: {{ ad.config|tojson }}
    - require:
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

# The samba stuff (net ads, smb.conf) etc does not hurt, but quickly gets confusing
# and if used could mess up what adcli is doing
samba_leftovers:
  pkg.purged:
    - pkgs:
      - samba-common
      - samba-dsdb-modules
