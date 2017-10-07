{% if salt['pillar.get']('apache2:modules', []) %}

include:
{% for module in salt['pillar.get']('apache2:modules', []) %}
  - .mod-{{ module }}
{% endfor %}

{% endif %}
