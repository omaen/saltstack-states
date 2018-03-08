include:
{% if salt['pillar.get']('systemd_resolved') is defined %}
  - .remove
{% else %}
  - .install
{% endif %}
