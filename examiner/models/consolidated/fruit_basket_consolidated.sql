{{ config(materialized='view', schema='PLAYGROUND',
   unique_key = ['PRIMARY_ID']) }}


{% set relations = dbt_utils.get_relations_by_pattern(
   schema_pattern = 'COLORED%BASKET',
    table_pattern = '%FRUIT',
    exclude = '',
    database = 'PLAYGROUND_DB') %}

with source as (

    select * from ({{ dbt_utils.union_relations(relations=relations) }})

    )

select * from source