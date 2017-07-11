{% if grains['oscodename'] == 'jessie' %}
include:
  - apt.repo-backports
{% endif %}

{% from 'borgbackup/map.jinja' import borgbackup with context %}

borgbackup:
  pkg.installed:
    - name: {{ borgbackup.borgbackup }}
{% if grains['oscodename'] == 'jessie' %}
    - fromrepo: jessie-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
