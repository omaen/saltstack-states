docker-cleanup:
  file.managed:
    - name: /etc/cron.weekly/docker-cleanup
    - source: salt://docker/files/docker-cleanup
    - user: root
    - group: root
    - mode: 755
