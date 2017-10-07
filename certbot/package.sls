{% if grains['oscodename'] == 'jessie' %}
include:
  - apt.repo-backports
{% endif %}

certbot:
  pkg.latest:
    - name: certbot
{% if grains['oscodename'] == 'jessie' %}
    - fromrepo: jessie-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
