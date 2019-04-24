{% from 'squid/map.jinja' import squid with context %}

include:
  - systemctl.daemon-reload

squid:
  pkg.installed:
    - name: {{ squid.package }}
  service.running:
    - name: {{ squid.service }}
    - reload: True
    - require:
      - pkg: squid

{% if squid.blacklists %}

squid_blacklists:
  file.managed:
    - name: {{ squid.blacklist_update_script }}
    - source: salt://squid/files/update-squid-blacklists
    - template: jinja
    - user: root
    - group: root
    - mode: 750
    - context:
        acl_dir: {{ squid.acl_dir }}
        blacklists: {{ squid.blacklists|tojson }}
        service: {{ squid.service }}

squid_blacklist_update_service:
  file.managed:
    - name: /etc/systemd/system/update-squid-blacklists.service
    - source: salt://squid/files/update-squid-blacklists.service
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: daemon-reload
    - context:
        blacklist_update_script: {{ squid.blacklist_update_script }}
  cmd.run:
    - name: systemctl start update-squid-blacklists.service
    - onchanges:
      - file: squid_blacklists
    - require:
      - file: squid_blacklist_update_service
    - watch_in:
      - service: squid

squid_blacklist_update_timer:
  file.managed:
    - name: /etc/systemd/system/update-squid-blacklists.timer
    - source: salt://squid/files/update-squid-blacklists.timer
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: daemon-reload
  service.running:
    - name: update-squid-blacklists.timer
    - enable: True
    - require:
      - file: squid_blacklist_update_service
      - file: squid_blacklist_update_timer

{% else %}

acl_dir_absent:
  file.absent:
    - name: {{ squid.acl_dir }}

blacklist_update_script_absent:
  file.absent:
    - name: {{ squid.blacklist_update_script }}

squid_blacklist_update_service_absent:
  file.absent:
    - name: /etc/systemd/system/update-squid-blacklists.service
    - watch_in:
      - cmd: daemon-reload
    - require:
      - service: squid_blacklist_update_timer_absent

squid_blacklist_update_timer_absent:
  file.absent:
    - name: /etc/systemd/system/update-squid-blacklists.timer
    - watch_in:
      - cmd: daemon-reload
    - require:
      - service: squid_blacklist_update_timer_absent
  service.disabled:
    - name: update-squid-blacklists.timer

{% endif %}
