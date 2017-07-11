{% if grains['oscodename'] == 'jessie' %}
include:
  - apt.repo-backports
{% endif %}

icinga2:
  pkg.installed:
    - name: icinga2
{% if grains['oscodename'] == 'jessie' %}
    - fromrepo: jessie-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
  service.running:
    - name: icinga2
    - require:
      - pkg: icinga2
