{%- from tpldir ~ "/map.jinja" import apt with context %}

repo-backports:
{% if apt.backports %}
  pkgrepo.managed:
    - name: {{ apt.backports }}
    - file: /etc/apt/sources.list.d/backports.list
    - clean_file: True
{% else %}
  file.absent:
    - name: /etc/apt/sources.list.d/backports.list
{% endif %}
