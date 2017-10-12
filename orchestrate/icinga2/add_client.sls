{% set data = salt.pillar.get('event_data') %}

icinga2_add_client:
  salt.state:
    - tgt: {{ data.data.client }}
    - sls:
      - icinga2.client
    - queue: True
    - pillar:
        icinga2:
          client:
            config:
              ticket: {{ data.data.ticket }}
