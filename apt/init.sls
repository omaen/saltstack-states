{%- from tpldir ~ "/map.jinja" import apt with context %}

apt-progs:
  pkg.installed:
    - pkgs:
      - aptitude
      - apt-transport-https
      - ca-certificates

{% if apt.sources %}
sources:
  file.managed:
    - name: /etc/apt/sources.list
    - source: salt://apt/files/sources.list
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        sources: {{ apt.sources|tojson }}
    - require_in:
      - pkg: apt-progs
{% endif %}

00proxy:
{% if apt.proxy %}
  file.managed:
    - name: {{ apt.proxy_config }}
    - source: salt://apt/files/00proxy
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        config: {{ apt.proxy|tojson }}
{% else %}
  file.absent:
    - name: {{ apt.proxy_config }}
{% endif %}
