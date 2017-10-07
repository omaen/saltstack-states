{% if pillar['borgbackup'] is defined %}

include:
  - borgbackup.package

{% endif %}
