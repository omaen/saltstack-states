{% from 'fwgen/map.jinja' import fwgen with context %}
{% if not fwgen.no_default_firewall %}
fwgen_config:
  file.managed:
    - name: /etc/fwgen/config.yml
    - contents_pillar: fwgen:config
    - makedirs: True
    - user: root
    - group: root
    - mode: 600
  cmd.wait:
    - name: fwgen apply --no-confirm
    - watch:
      - pip: fwgen
      - file: fwgen_config
    - require:
      - pip: fwgen
      - file: fwgen_config
{% endif %}

fwgen_service:
  file.managed:
    - name: /etc/systemd/system/fwgen.service
    - source: salt://fwgen/files/fwgen.service
    - template: jinja
    - user: root
    - group: root
    - mode: 644
  service.enabled:
    - name: fwgen
    - require:
      - file: fwgen_service
