{%- from tpldir ~ "/map.jinja" import nftables with context %}

{% if nftables.use_backports %}
include:
  - apt.repo-backports
{% endif %}

nftables-pkg:
  pkg.installed:
    - name: {{ nftables.pkg }}
{% if nftables.use_backports %}
    - fromrepo: {{ grains['oscodename']|lower }}-backports
    - require:
      - pkgrepo: repo-backports
{% endif %}
