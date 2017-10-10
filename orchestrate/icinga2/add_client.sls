{% set data = salt.pillar.get('event_data') %}

icinga2_add_client:
  salt.state:
    - tgt: {{ data.data.client }}
    - sls:
      - icinga2.client
    - pillar:
        icinga2:
          ticket: {{ data.data.ticket }}
