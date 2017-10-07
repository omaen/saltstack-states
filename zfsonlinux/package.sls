{% if grains['oscodename'] == 'jessie' or grains['oscodename'] == 'stretch' %}
include:
  - apt.repo-backports
{% endif %}

{% from 'zfsonlinux/map.jinja' import zfsonlinux with context %}

zfsonlinux:
  pkg.installed:
    - pkgs:
      - {{ zfsonlinux.dkms }}
      - {{ zfsonlinux.zfsutils }}
      - {{ zfsonlinux.zed }}
{% if grains['oscodename'] == 'jessie' %}
    - fromrepo: jessie-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
{% if grains['oscodename'] == 'stretch' %}
    - fromrepo: stretch-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
  service.running:
    - name: {{ zfsonlinux.zed }}
    - require:
      - pkg: zfsonlinux
