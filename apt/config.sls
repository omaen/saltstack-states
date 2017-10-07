{% from 'apt/map.jinja' import apt with context %}

{%- set os = grains['os_family'] | lower %}
{%- set codename = grains['oscodename'] | lower %}
sources:
  file.managed:
    - name: /etc/apt/sources.list
    - source: salt://apt/files/sources.list
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
      sources: {{ apt[os][codename].sources }}
