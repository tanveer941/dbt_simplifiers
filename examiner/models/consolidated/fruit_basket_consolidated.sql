-- This configuration block sets the materialization type to 'view',
-- specifies the schema as 'PLAYGROUND', and defines 'PRIMARY_ID' as the unique key.
{{ config(materialized='view', schema='PLAYGROUND', unique_key = ['PRIMARY_ID']) }}

-- Retrieve a list of relations (tables or views) from the database 'PLAYGROUND_DB'
-- that match the schema pattern 'COLORED%BASKET' and table pattern '%FRUIT'.
{% set relations = dbt_utils.get_relations_by_pattern(
   schema_pattern = 'COLORED%BASKET',
   table_pattern = '%FRUIT',
   exclude = '',
   database = 'PLAYGROUND_DB') %}

-- Define a CTE (Common Table Expression) named 'source' that unions all the relations
-- retrieved by the previous dbt_utils.get_relations_by_pattern function.
with source as (
    select * from ({{ dbt_utils.union_relations(relations=relations) }})
)

-- Select all columns from the 'source' CTE.
select * from source