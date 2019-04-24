{% from 'docker/map.jinja' import docker with context %}

/etc/cron.weekly/docker-cleanup:
{% if docker.config.weekly_cleanup %}
  file.managed:
    - source: salt://docker/files/docker-cleanup
    - user: root
    - group: root
    - mode: 755
{% else %}
  file.absent
{% endif %}

daemon.json:
  file.managed:
    - name: /etc/docker/daemon.json
    - source: salt://docker/files/daemon.json
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ docker.config.daemon|tojson }}
    - watch_in:
      - service: docker
