{% if pillar['zfsonlinux'] is defined %}

include:
  - zfsonlinux.package

{% endif %}
