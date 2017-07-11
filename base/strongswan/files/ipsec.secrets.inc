{{ salt['pillar.get']('salt:managed_file_header', '# This file is managed by Salt') }}
{% for secret in secrets %}
{{ secret }}
{%- endfor %}
