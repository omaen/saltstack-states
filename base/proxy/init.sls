{% if pillar['proxy'] is defined %}

include:
  {% if salt['pillar.get']('proxy:disable', False) %}
  - .remove
  {% else %}
  - .config
  {% endif %}

{% endif %}
