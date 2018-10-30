{% if salt['pillar.get']('ddclient', False) %}

include:
  - ddclient.package
  - ddclient.config

{% endif %}
