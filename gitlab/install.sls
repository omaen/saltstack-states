{%- from tpldir ~ "/map.jinja" import gitlab with context %}

gitlab:
  pkgrepo.managed:
    - name: {{ gitlab[gitlab.edition]['repo'] }}
    - key_url: {{ gitlab[gitlab.edition]['key_url'] }}
    - file: /etc/apt/sources.list.d/gitlab.list
    - clean_file: True
  pkg.installed:
    - name: {{ gitlab[gitlab.edition]['package'] }}
    {% if gitlab.version %}
    - version: {{ gitlab.version }}
    {% endif %}
    - hold: True
    - require:
      - pkgrepo: gitlab
