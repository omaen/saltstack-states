{%- from tpldir ~ "/map.jinja" import elasticsearch with context %}

include:
  - elastic.repo
  - .cluster-health

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

{% if elasticsearch.install_java %}
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
      - pkgrepo: elastic-repo
    - prereq_in:
      - cmd: cluster-health-ok
  service.running:
    - name: {{ elasticsearch.service }}
    - enable: True
    - require:
      - pkg: elasticsearch
