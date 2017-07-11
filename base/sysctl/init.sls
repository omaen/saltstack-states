{% if pillar['sysctl'] is defined %}
include:
    - sysctl.config
{% endif %}
