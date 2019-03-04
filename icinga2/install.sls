{% from 'icinga2/map.jinja' import icinga2 with context %}

{% if icinga2.use_backports %}
include:
  - apt.repo-backports
{% endif %}

icinga2:
  pkg.installed:
    - name: {{ icinga2.pkg }}
{% if icinga2.use_backports %}
    - fromrepo: {{ grains['oscodename']|lower }}-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
