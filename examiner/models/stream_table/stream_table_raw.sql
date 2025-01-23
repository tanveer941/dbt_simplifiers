{{ config(
    schema='USAGE_TRANSFORM',
    unique_key = ['SESSION_ID'],
    alias= 'USAGE_LOGIN',
    materialized='incremental',
)}}
 
-- Call the perform_incremental macro to perform an incremental load.
-- Parameters:
--   source_schema: The schema of the source table.
--   source_table_name: The name of the source table.
--   timestamp_incremental: The column used for incremental loading, which should be of type timestamp.
{{ perform_incremental(source_schema='USAGE_TRANSFORM',
                        source_table_name='USAGE_LOGIN_RAW',
                        timestamp_incremental='LOAD_START_TIME') }}