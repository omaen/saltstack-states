{%- if grains['oscodename'] != 'jessie' %}

include:
  - .install
  - .config

{%- endif %}
