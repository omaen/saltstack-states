{%- from tpldir ~ "/map.jinja" import nftables with context %}

nftables-pkg:
  pkg.installed:
    - name: {{ nftables.pkg }}
{% if nftables.use_backports %}
    - fromrepo: {{ grains['oscodename']|lower }}-backports
{% endif %}
