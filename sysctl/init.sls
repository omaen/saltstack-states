{% if pillar['sysctl'] is defined %}

include:
    - .config

{% endif %}
