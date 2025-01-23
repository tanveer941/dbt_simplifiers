{%- macro perform_incremental(source_schema, source_table_name, timestamp_incremental) -%}

-- Log the execution of the macro with the provided schema, table name, and timestamp column.
{{ log("Running macro perform_incremental : " ~ source_schema ~ ", " ~ source_table_name ~ "," ~ timestamp_incremental) }}

-- Define a CTE (Common Table Expression) named 'source' that selects all columns from the specified source table.
with source as (
    select * from {{ source_schema }}.{{ source_table_name }}
    )
select * from source

-- If the current run is incremental, add a WHERE clause to filter rows based on the timestamp column.
{%- if is_incremental() -%}
{{ '\n  ' }}
where (NVL( {{timestamp_incremental}}, SYSTIMESTAMP()) > (select NVL( max( {{timestamp_incremental}} ), TO_TIMESTAMP(1)) from {{ this }}))
{%- endif -%}

{%- endmacro -%}