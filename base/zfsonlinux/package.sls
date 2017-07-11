{% if grains['oscodename'] == 'jessie' %}
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
  service.running:
    - name: {{ zfsonlinux.zed }}
    - require:
      - pkg: zfsonlinux
