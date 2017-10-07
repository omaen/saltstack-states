saslauth:
  pkg.installed:
    - name: sasl2-bin
  file.replace:
    - name: /etc/default/saslauthd
    - pattern: ^START=.*
    - repl: START=yes
    - require:
      - pkg: saslauth
  service.running:
    - name: saslauthd
    - require:
      - file: saslauth

saslauth_config:
  user.present:
    - name: Debian-exim
    - groups: ['sasl']
    - remove_groups: False
    - require:
      - pkg: exim4
      - pkg: saslauth
  file.managed:
    - name: /etc/exim4/conf.d/auth/10_exim4-config_saslauth
    - source: salt://exim4/files/10_exim4-config_saslauth
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: exim4
    - require:
      - file: exim4_conf
      - service: saslauth
      - user: saslauth_config
