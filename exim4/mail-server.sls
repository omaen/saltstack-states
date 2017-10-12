include:
  - exim4.package
  - exim4.config
  - exim4.tls
{% if salt['pillar.get']('exim4:dkim') %}
  - exim4.dkim
{% endif %}
{% if salt['pillar.get']('exim4:enable_spf') %}
  - exim4.spf
{% endif %}
{% if salt['pillar.get']('exim4:enable_auth') %}
  - exim4.auth
{% endif %}

dovecot_lda_config:
  file.managed:
    - name: /etc/exim4/conf.d/transport/20_exim4-config_dovecot
    - source: salt://exim4/files/20_exim4-config_dovecot
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: exim4
    - require:
      - file: exim4_conf

custom_config:
  file.managed:
    - name: /etc/exim4/conf.d/main/00_exim4-config_custom
    - source: salt://exim4/files/00_exim4-config_custom
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: exim4
    - require:
      - file: exim4_conf
