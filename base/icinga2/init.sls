{% if salt['pillar.get']('icinga2:ticket', False) %}
include:
  - .package
  - .config
  - .command-execution-client
{% endif %}
