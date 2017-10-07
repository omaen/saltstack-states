{% if pillar['exim4'] is defined %}

include:
    - exim4.package
    - exim4.config

{% endif %}
