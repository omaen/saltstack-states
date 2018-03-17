{% if grains['oscodename'] in ['jessie', 'stretch'] %}
include:
  - apt.repo-backports
{% endif %}

{% from 'borgbackup/map.jinja' import borgbackup with context %}

borgbackup:
  pkg.installed:
    - name: {{ borgbackup.borgbackup }}
{% if grains['oscodename'] in ['jessie', 'stretch'] %}
    - version: latest
    - fromrepo: {{ grains['oscodename'] }}-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
