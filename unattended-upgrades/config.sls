{% from 'unattended-upgrades/map.jinja' import unattended_upgrades with context %}

50unattended-upgrades:
  file.managed:
    - name: {{ unattended_upgrades.unattended_upgrades_config }}
    {% if grains['os'] == 'Raspbian' %}
    - source: salt://unattended-upgrades/files/50unattended-upgrades_raspbian
    {% else %}
    - source: salt://unattended-upgrades/files/50unattended-upgrades
    {% endif %}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ unattended_upgrades.unattended_upgrades|tojson }}

20auto-upgrades:
  file.managed:
    - name: {{ unattended_upgrades.auto_upgrades_config }}
    - source: salt://unattended-upgrades/files/20auto-upgrades
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ unattended_upgrades.auto_upgrades|tojson }}

listchanges_conf:
  file.managed:
    - name: {{ unattended_upgrades.listchanges_config }}
    - source: salt://unattended-upgrades/files/listchanges.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ unattended_upgrades.listchanges|tojson }}
