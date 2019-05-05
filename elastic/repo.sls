{%- from tpldir ~ "/map.jinja" import elastic with context %}

elastic-repo:
  pkgrepo.managed:
    - name: {{ elastic.repo[elastic.repo_version] }}
    - key_url: {{ elastic.key_url }}
    - file: /etc/apt/sources.list.d/elastic.list
    - clean_file: True
