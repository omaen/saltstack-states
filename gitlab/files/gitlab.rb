{%- set indent_base = 2 %}
{%- macro value_renderer(value, indent=indent_base) %}
    {%- if value is mapping %}{
        {%- for k, v in value.items() %}
{{ "'"|indent(indent, true) }}{{ k }}' => {{ value_renderer(v, indent + indent_base) }},
        {%- endfor %}
{{ '}'|indent(indent - indent_base, true) }}
    {%- elif value is list %}[
        {%- for i in value %}
{{ value_renderer(i, indent)|indent(indent, true) }},
        {%- endfor %}
{{ ']'|indent(indent - indent_base, true) }}
    {%- else -%}
'{{ value }}'
    {%- endif %}
{%- endmacro -%}

#
# This file is managed by Salt. Changes will be overwritten!
#
# The original config file template is available at:
# https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template
#
{% for param in config %}
    {%- if param is mapping %}
        {%- for k, v in param.items() %}
            {%- for k_1, v_1 in v.items() %}
{{ k }}['{{ k_1 }}'] = {{ value_renderer(v_1) }}
            {%- endfor %}
        {%- endfor %}
    {%- else %}
{{ param }}
    {%- endif %}
{%- endfor %}
