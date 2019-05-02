{%- from tpldir ~ "/map.jinja" import elasticsearch with context %}

{% for k in elasticsearch.disk_mounts %}
{{ k }}:
  blockdev.formatted:
    - fs_type: {{ elasticsearch.disk_mounts[k].get('fs_type', 'ext4') }}
  mount.mounted:
    - name: {{ elasticsearch.disk_mounts[k].get('mount_point') }}
    - device: {{ k }}
    - fstype: {{ elasticsearch.disk_mounts[k].get('fs_type', 'ext4') }}
    - opts: {{ elasticsearch.disk_mounts[k].get('options', [])|tojson }}
    - persist: True
    - mkmnt: True
    - require:
      - blockdev: {{ k }}
    - require_in:
      - pkg: elasticsearch
{% endfor %}

elasticsearch-repo:
  pkgrepo.managed:
    - name: {{ elasticsearch.repo[elasticsearch.repo_version] }}
    - key_url: {{ elasticsearch.key_url }}
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - clean_file: True

{% if elasticsearch.repo_version in ['5.x', '6.x'] %}
elasticsearch-java:
  pkg.installed:
    - name: {{ elasticsearch.java_package }}
    - require_in:
      - pkg: elasticsearch
{% endif %}

elasticsearch:
  pkg.installed:
    - name: {{ elasticsearch.package }}
    {% if elasticsearch.version %}
    - version: {{ elasticsearch.version }}
    {% endif %}
    - hold: True
    - require:
      - pkgrepo: elasticsearch-repo
  service.running:
    - name: {{ elasticsearch.service }}
    - enable: True
    - require:
      - pkg: elasticsearch
