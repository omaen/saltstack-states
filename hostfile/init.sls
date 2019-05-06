{% for ip, hostnames in pillar.get('hostfile', {}).items() %}
hostfile entry {{ ip }}:
  host.only:
    - name: {{ ip }}
    - hostnames: {{ hostnames|tojson }}
{% endfor %}
