{% if salt['pillar.get']('borgwrapper:configs', {}) %}

include:
  - borgwrapper.package
  - borgwrapper.config

{% endif %}
