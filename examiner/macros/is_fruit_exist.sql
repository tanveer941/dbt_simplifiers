{% macro is_fruit_exist(fruit_name) -%}

{%- call statement('get_fruits', fetch_result=True) -%}

        select
            lower(fruit_id)
        from
            {{ ref('fruit_basket_consolidated') }}
        where
             lower(fruit_name) = lower('{{ fruit_name }}')

{%- endcall -%}

{%- set derived_result = load_result('get_fruits') -%}

{%- set derived_fruits = [] -%}

{%- if derived_result and derived_result['data'] -%}
      {%- set derived_fruits = derived_result['data'] | map(attribute=0) | list -%}

{%- endif -%}

{%- set fruit_exists = derived_fruits | length > 0 -%}

{{ return(fruit_exists) }}

{%- endmacro -%}
