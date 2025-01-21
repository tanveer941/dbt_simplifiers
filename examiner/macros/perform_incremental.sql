
{%- macro perform_incremental(source_schema, source_table_name, timestamp_incremental) -%}

{{ log("Running macro perform_incremental : " ~ source_schema ~ ", " ~ source_table_name ~ "," ~ timestamp_incremental) }}

with source as (
    select * from {{ source_schema }}.{{ source_table_name }}
    )
select * from source

{%- if is_incremental() -%}
{{ '\n  ' }}
where (NVL( {{timestamp_incremental}}, SYSTIMESTAMP()) > (select NVL( max( {{timestamp_incremental}} ), TO_TIMESTAMP(1)) from {{ this }}))
{%- endif -%}

{%- endmacro -%}