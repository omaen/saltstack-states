{% if grains['oscodename'] == 'jessie' %}
include:
  - apt.repo-backports
{% endif %}

vmware-tools-desktop:
  pkg.latest:
    - name: open-vm-tools-desktop
{% if grains['oscodename'] == 'jessie' %}
    - fromrepo: jessie-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
