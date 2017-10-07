tls_config:
  file.managed:
    - name: /etc/exim4/conf.d/main/00_exim4-config_tls
    - source: salt://exim4/files/00_exim4-config_tls
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: exim4
    - require:
      - file: exim4_conf

{% if salt['pillar.get']('exim4:certificate', False) %}
tls_cert:
  file.managed:
    - name: /etc/exim4/exim.crt
    - contents_pillar: 'exim4:certificate'
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: exim4
    - require:
      - pkg: exim4
    - require_in:
      - file: tls_config

tls_key:
  file.managed:
    - name: /etc/exim4/exim.key
    - contents_pillar: 'exim4:key'
    - user: root
    - group: Debian-exim
    - mode: 640
    - watch_in:
      - service: exim4
    - require:
      - pkg: exim4
    - require_in:
      - file: tls_config
{% endif %}
