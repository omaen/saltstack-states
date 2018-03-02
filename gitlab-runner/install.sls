{% from 'gitlab-runner/map.jinja' import gitlab_runner with context %}

gitlab-runner:
  pkgrepo.managed:
    - name: {{ gitlab_runner.repo }}
    - key_url: {{ gitlab_runner.key_url }}
    - file: /etc/apt/sources.list.d/gitlab-runner.list
    - clean_file: True
  pkg.installed:
    - name: {{ gitlab_runner.package }}
    - require:
      - pkgrepo: gitlab-runner
  service.running:
    - name: {{ gitlab_runner.service }}
    - require:
      - pkg: gitlab-runner
