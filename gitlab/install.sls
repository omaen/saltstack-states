{% from 'gitlab/map.jinja' import gitlab with context %}

gitlab:
  pkgrepo.managed:
    - name: {{ gitlab[gitlab.edition]['repo'] }}
    - key_url: {{ gitlab[gitlab.edition]['key_url'] }}
    - file: /etc/apt/sources.list.d/gitlab.list
    - clean_file: True
  pkg.installed:
    - name: {{ gitlab[gitlab.edition]['package'] }}
    - require:
      - pkgrepo: gitlab
