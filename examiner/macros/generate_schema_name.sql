{%- macro generate_schema_name(custom_schema_name, node) -%}

    {%- set dev_targets = ('dev') -%}
    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema | trim }}

    {%- elif target.name in dev_targets -%}

        {{ default_schema }}_{{ custom_schema_name | trim }}

    {%- else -%}

        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro -%}