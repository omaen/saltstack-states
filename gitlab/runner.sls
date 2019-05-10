{%- from tpldir ~ "/map.jinja" import gitlab with context %}
{% set runner = gitlab.runner %}

gitlab-runner:
  pkgrepo.managed:
    - name: {{ runner.repo }}
    - key_url: {{ runner.key_url }}
    - file: /etc/apt/sources.list.d/gitlab-runner.list
    - clean_file: True
  pkg.installed:
    - name: {{ runner.package }}
    {% if runner.version %}
    - version: {{ runner.version }}
    {% endif %}
    - hold: True
    - require:
      - pkgrepo: gitlab-runner
  service.running:
    - name: {{ runner.service }}
    - require:
      - pkg: gitlab-runner

gitlab-runner_concurrent:
  file.replace:
    - name: /etc/gitlab-runner/config.toml
    - pattern: ^concurrent = [0-9]+$
    - repl: concurrent = {{ runner.config.concurrent }}
    - ignore_if_missing: True
    - watch_in:
      - service: gitlab-runner
