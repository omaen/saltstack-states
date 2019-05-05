{%- from tpldir ~ "/map.jinja" import mongodb with context %}

mongodb-repo:
  pkgrepo.managed:
    - name: {{ mongodb.repo[mongodb.repo_version] }}
    {% if mongodb.repo_key_url %}
    - key_url: {{ mongodb.repo_key_url }}
    {% else %}
    - keyserver: {{ mongodb.repo_keyserver }}
    - keyid: {{ mongodb.repo_keyid }}
    {% endif %}
    - file: /etc/apt/sources.list.d/mongodb.list
    - clean_file: True

mongodb:
  pkg.installed:
    - pkgs:
      {% for pkg in mongodb.packages %}
        {% if mongodb.version %}
      - {{ pkg }}: {{ mongodb.version }}
        {% else %}
      - {{ pkg }}
        {% endif %}
      {% endfor %}
    - hold: True
    - require:
      - pkgrepo: mongodb-repo
  service.running:
    - name: {{ mongodb.service }}
    - enable: true
    - require:
      - pkg: mongodb
