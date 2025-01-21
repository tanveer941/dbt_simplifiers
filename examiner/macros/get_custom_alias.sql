{%- macro generate_alias_name(custom_alias_name=none, node=none) -%}

    {%- set skip_targets = ('test') -%}

    {%- if custom_alias_name is none or target.name in skip_targets -%}

        {{ node.name }}

    {%- elif node.package_name == 'elementary' -%}

        {{ return(custom_alias_name ~ "_" ~ node.name) }}

    {%- elif node.version -%}

        {{ return(node.name ~ "_v" ~ (node.version | replace(".", "_"))) }}

    {%- else -%}

        {{ custom_alias_name | trim }}

    {%- endif -%}

{%- endmacro -%}
