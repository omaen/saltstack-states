{% from 'icinga2/map.jinja' import icinga2 with context %}

icinga2_create_new_ticket:
  cmd.script:
    - source: salt://icinga2/files/new_ticket_event.py
    - env:
      - CLIENT: {{ icinga2.orchestrate.master.new_ticket.client }}
