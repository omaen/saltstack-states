{% from 'docker/map.jinja' import docker with context %}

docker-cleanup:
  file.managed:
    - name: /etc/cron.weekly/docker-cleanup
    - source: salt://docker/files/docker-cleanup
    - user: root
    - group: root
    - mode: 755

daemon.json:
  file.managed:
    - name: /etc/docker/daemon.json
    - source: salt://docker/files/daemon.json
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ docker.config.daemon }}
    - watch_in:
      - service: docker
