{% if salt['pillar.get']('borgwrapper:configs', {}) %}

include:
  - .package
  - .config

{% endif %}
