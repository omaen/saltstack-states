{% set data = salt.pillar.get('event_data') %}

borgbackup_add_public_key:
  salt.state:
    - tgt: {{ data.data.server }}
    - sls:
      - borgbackup.server
    - queue: True
    - pillar:
        borgbackup:
          orchestrate:
            server:
              new_client:
                id: {{ data.id }}
                public_key: {{ data.data.public_key }}
