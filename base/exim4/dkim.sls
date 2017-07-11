dkim_keys_dir:
  file.directory:
    - name: /etc/exim4/keys
    - user: root
    - group: Debian-exim
    - mode: 750
    - require:
      - pkg: exim4

dkim_key:
  file.managed:
    - name: /etc/exim4/keys/dkim.{{ salt['pillar.get']('exim4:dkim:selector') }}.key
    - source: salt://exim4/dkim/dkim.{{ salt['pillar.get']('exim4:dkim:selector') }}.key
    - user: root
    - group: Debian-exim
    - mode: 640
    - require:
      - file: dkim_keys_dir

dkim_pub_key:
  file.managed:
    - name: /etc/exim4/keys/dkim.{{ salt['pillar.get']('exim4:dkim:selector') }}.pub
    - source: salt://exim4/dkim/dkim.{{ salt['pillar.get']('exim4:dkim:selector') }}.pub
    - user: root
    - group: Debian-exim
    - mode: 644
    - require:
      - file: dkim_keys_dir

dkim_config:
  file.managed:
    - name: /etc/exim4/conf.d/main/00_exim4-config_dkim
    - source: salt://exim4/files/00_exim4-config_dkim
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: exim4
    - require:
      - file: exim4_conf
      - file: dkim_key
      - file: dkim_pub_key

dkim_smarthost_config:
  file.managed:
    - name: /etc/exim4/conf.d/transport/30_exim4-config_remote_smtp_smarthost_dkim
    - source: salt://exim4/files/30_exim4-config_remote_smtp_smarthost_dkim
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: exim4
    - require:
      - file: dkim_config
