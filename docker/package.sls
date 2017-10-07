{% from 'docker/map.jinja' import docker with context %}

repo-docker:
  pkgrepo.managed:
    - name: {{ docker.repo }}
    - key_url: {{ docker.key_url }}
    - file: /etc/apt/sources.list.d/docker.list
    - clean_file: True

docker-ce:
  pkg.installed:
    - name: {{ docker.ce_package }}
    - require:
      - pkgrepo: repo-docker
  service.running:
    - name: {{ docker.service }}
    - require:
      - pkg: docker-ce
