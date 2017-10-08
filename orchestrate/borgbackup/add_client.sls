{% set data = salt.pillar.get('event_data') %}

add_ssh_key:
  salt.state:
    - tgt: {{ data.data.server }}
    - sls:
      - borgbackup.server
    - pillar:
        borgbackup:
          new_client:
            id: {{ data.id }}
            public_key: {{ data.data.public_key }}
