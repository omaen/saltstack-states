{% if salt['pillar.get']('icinga2:ticket', False) %}
include:
  - .install
  - .config
  - .command-execution-client
{% endif %}
