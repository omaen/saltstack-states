{% from 'zfsonlinux/map.jinja' import zfsonlinux with context %}

{% if zfsonlinux.use_backports %}
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
{% if zfsonlinux.use_backports %}
    - fromrepo: {{ grains['oscodename'] }}-backports
    - version: latest
    - require:
      - pkgrepo: repo-backports
{% endif %}
  service.running:
    - name: {{ zfsonlinux.zed }}
    - require:
      - pkg: zfsonlinux
