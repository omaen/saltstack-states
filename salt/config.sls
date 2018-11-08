{% from 'salt/map.jinja' import salt_config with context %}

minion_config:
  file.managed:
    - name: /etc/salt/minion.d/salt.conf
    - source: salt://salt/files/minion
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ salt_config.config.minion }}
    - watch_in:
      - service: salt-minion

{% if salt_config.auto_apply_schedule.enable %}

auto_apply_schedule:
  schedule.present:
    - function: state.apply
    - hours: {{ salt_config.auto_apply_schedule.hours }}
    - splay: {{ salt_config.auto_apply_schedule.splay }}

{% endif %}
