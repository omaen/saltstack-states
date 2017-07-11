{% if grains['oscodename'] == 'jessie' %}
include:
  - apt.repo-backports
{% endif %}

salt-minion:
  pkg.installed:
    - name: salt-minion
{% if grains['oscodename'] == 'jessie' %}
    - fromrepo: jessie-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
  service.running:
    - name: salt-minion
    - require:
      - pkg: salt-minion
