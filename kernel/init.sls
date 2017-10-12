{% if salt.pillar.get('kernel') == 'backports'  %}

include:
  - apt.repo-backports

kernel-debian-backports:
  pkg.installed:
    - name: linux-image-amd64
    - fromrepo: {{ grains['oscodename'] }}-backports
    - version: latest
    - require:
      - pkgrepo: repo-backports

{% endif %}
