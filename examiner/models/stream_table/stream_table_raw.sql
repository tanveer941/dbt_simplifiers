{{ config(
    schema='USAGE_TRANSFORM',
    unique_key = ['SESSION_ID'],
    alias= 'USAGE_LOGIN',
    materialized='incremental',
)}}
 
{{ perform_incremental(source_schema='USAGE_TRANSFORM',
                        source_table_name='USAGE_LOGIN_RAW',
                        timestamp_incremental='LOAD_START_TIME') }}