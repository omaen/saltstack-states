{%- from tpldir ~ "/map.jinja" import aptly with context %}

aptly-pkg:
  pkg.installed:
    - name: {{ aptly.pkg }}
{% if aptly.use_backports %}
    - fromrepo: {{ grains['oscodename']|lower }}-backports
{% endif %}
