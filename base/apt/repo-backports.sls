{% from 'apt/map.jinja' import apt with context %}

{%- set codename = grains['oscodename'] | lower %}
repo-backports:
  pkgrepo.managed:
    - name: {{ apt.debian[codename].backports }}
    - file: /etc/apt/sources.list.d/backports.list
    - clean_file: True
