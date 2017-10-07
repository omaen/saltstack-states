{% if pillar['mariadb_backup'] is defined %}

include:
  - .package
  - .config

{% endif %}
