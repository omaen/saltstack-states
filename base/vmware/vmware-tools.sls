{% if grains['oscodename'] == 'jessie' %}
include:
  - apt.repo-backports
{% endif %}

vmware-tools:
  pkg.latest:
    - name: open-vm-tools
{% if grains['oscodename'] == 'jessie' %}
    - fromrepo: jessie-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
