{% set data = salt.pillar.get('event_data') %}

icinga2_get_ticket:
  salt.state:
    - tgt: {{ data.data.master }}
    - sls:
      - icinga2.new_ticket
    - queue: True
    - pillar:
        icinga2:
          orchestrate:
            master:
              new_ticket:
                client: {{ data.data.client }}
