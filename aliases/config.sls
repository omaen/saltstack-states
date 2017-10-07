{% from 'aliases/map.jinja' import aliases with context %}

newaliases:
  cmd.wait:
    - name: newaliases

{% for alias, deliver_to in salt['pillar.get']('aliases:aliases', {}).iteritems() %}
alias_{{ alias }}:
  file.replace:
    - name: {{ aliases.aliases_file }}
    - pattern: '^{{ alias }}:.*$'
    - repl: '{{ alias }}: {{ deliver_to | join(' ') }}'
    - append_if_not_found: True
    - watch_in:
      - cmd: newaliases
{% endfor %}
