{% set use_backports = ['jessie', 'stretch'] %}

{% if grains['oscodename'] in use_backports %}
include:
  - apt.repo-backports
{% endif %}

certbot:
  pkg.latest:
    - name: certbot
{% if grains['oscodename'] in use_backports %}
    - fromrepo: {{ grains['oscodename'] }}-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
