{% from 'bird/map.jinja' import bird with context %}

bird_conf:
  file.managed:
    - name: {{ bird.bird_conf }}
    - source: salt://bird/files/bird.conf
    - template: jinja
    - user: bird
    - group: bird
    - mode: 640
    - context:
        # Filter via json to avoid unset dict values becoming 'None'
        config: {{ bird.bird_config|json }}

{% if bird.bird_disable %}
  service.dead:
    - name: {{ bird.bird_service }}
    - enable: False
{% else %}
  service.running:
    - name: {{ bird.bird_service }}
    - enable: True
    - reload: True
    - watch:
      - file: bird_conf
    - require:
      - pkg: bird
{% endif %}

bird6_conf:
  file.managed:
    - name: {{ bird.bird6_conf }}
    - source: salt://bird/files/bird.conf
    - template: jinja
    - user: bird
    - group: bird
    - mode: 640
    - context:
        # Filter via json to avoid unset dict values becoming 'None'
        config: {{ bird.bird6_config|json }}

{% if bird.bird6_disable %}
  service.dead:
    - name: {{ bird.bird6_service }}
    - enable: False
{% else %}
  service.running:
    - name: {{ bird.bird6_service }}
    - enable: True
    - reload: True
    - watch:
      - file: bird6_conf
    - require:
      - pkg: bird
{% endif %}
