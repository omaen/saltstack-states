{% from 'apt/map.jinja' import apt with context %}

{% set os = grains['os'] | lower %}
{% set codename = grains['oscodename'] | lower %}
sources:
  file.managed:
    - name: /etc/apt/sources.list
    - source: salt://apt/files/sources.list
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        sources: {{ apt[os][codename].sources|tojson }}
    - require:
      - pkg: apt-progs

00proxy:
{% if apt.proxy.url is defined %}
  file.managed:
    - name: {{ apt.proxy.config }}
    - source: salt://apt/files/00proxy
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ apt.proxy|tojson }}
{% else %}
  file.absent:
    - name: {{ apt.proxy.config }}
{% endif %}
