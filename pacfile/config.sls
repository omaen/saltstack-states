{% from 'pacfile/map.jinja' import pacfile with context %}

pacfile:
  file.managed:
    - name: {{ pacfile.name }}
    - source: salt://pacfile/files/pacfile
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        # Filter via json to avoid syntax issues with the pacfile contents
        content: {{ pacfile.content|json }}
