{% from 'borgwrapper/map.jinja' import borgwrapper with context %}

reload_systemd_config:
  cmd.wait:
    - name: systemctl daemon-reload

{% for name, params in borgwrapper.configs.iteritems() %}
{% set config = borgwrapper.config_defaults %}
{% do config.update(params) %}
{% set config_file = [borgwrapper.config_dir, name + '.sh'] | join('/') %}

borgwrapper_{{ name }}_config:
  file.managed:
    - name: {{ config_file }}
    - source: salt://borgwrapper/files/config.sh
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - makedirs: True
    - context:
        config: {{ config }}

borgwrapper_{{ name }}_backup_service:
  file.managed:
    - name: /etc/systemd/system/borgwrapper-backup@.service
    - source: salt://borgwrapper/files/borgwrapper-backup@.service
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: reload_systemd_config

borgwrapper_{{ name }}_backup_timer:
  file.managed:
    - name: /etc/systemd/system/borgwrapper-backup@.timer
    - source: salt://borgwrapper/files/borgwrapper-backup@.timer
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: reload_systemd_config
  cmd.run:
    - name: systemctl enable borgwrapper-backup@{{ name }}.timer
    - unless: systemctl is-enabled borgwrapper-backup@{{ name }}.timer
    - require:
      - file: borgwrapper_{{ name }}_backup_service
      - file: borgwrapper_{{ name }}_backup_timer
  service.running:
    - name: borgwrapper-backup@{{ name }}.timer
    - require:
      - cmd: systemctl enable borgwrapper-backup@{{ name }}.timer

borgwrapper_{{ name }}_verify_service:
  file.managed:
    - name: /etc/systemd/system/borgwrapper-verify@.service
    - source: salt://borgwrapper/files/borgwrapper-verify@.service
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: reload_systemd_config

borgwrapper_{{ name }}_verify_timer:
  file.managed:
    - name: /etc/systemd/system/borgwrapper-verify@.timer
    - source: salt://borgwrapper/files/borgwrapper-verify@.timer
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: reload_systemd_config
  cmd.run:
    - name: systemctl enable borgwrapper-verify@{{ name }}.timer
    - unless: systemctl is-enabled borgwrapper-verify@{{ name }}.timer
    - require:
      - file: borgwrapper_{{ name }}_verify_service
      - file: borgwrapper_{{ name }}_verify_timer
  service.running:
    - name: borgwrapper-verify@{{ name }}.timer
    - require:
      - cmd: systemctl enable borgwrapper-verify@{{ name }}.timer

{% endfor %}
