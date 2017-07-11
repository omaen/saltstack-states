{% if grains['oscodename'] == 'jessie' %}
include:
  - apt.repo-backports
{% endif %}

kernel-debian-backports:
  pkg.installed:
{% if grains['oscodename'] == 'jessie' %}
    - name: linux-image-amd64
    - fromrepo: jessie-backports
    - version: latest
    - require:
      - pkgrepo: repo-backports
{% endif %}
