{% from 'gitlab-runner/map.jinja' import gitlab_runner with context %}

gitlab-runner_concurrent:
  file.replace:
    - name: /etc/gitlab-runner/config.toml
    - pattern: ^concurrent = [0-9]+$
    - repl: concurrent = {{ gitlab_runner.config.concurrent }}
    - ignore_if_missing: True
    - watch_in:
      - service: gitlab-runner
