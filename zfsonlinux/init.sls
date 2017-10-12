{% if pillar['zfsonlinux'] is defined %}

include:
  - .package

{% endif %}
