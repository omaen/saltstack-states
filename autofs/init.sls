{% if pillar['autofs'] is defined %}

include:
  - autofs.package
  - autofs.config

{% endif %}
