#
# This file is managed by Salt. Changes will be overwritten!
#
{% for secret in secrets %}
{{ secret }}
{%- endfor %}
