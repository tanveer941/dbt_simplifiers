{% macro fruit_table_creation() -%}

{% set fruit_qry %}
CREATE OR REPLACE TABLE FRUIT_DB.FRUIT_SCHEMA.FRUIT_TABLE AS
SELECT
fruit_id,
fruit_name,
to_date(start_time) AS export_dt,
FROM FRUIT_DB.FRUIT_SCHEMA.BASE_FRUIT_TABLE
GROUP BY fruit_id,fruit_name,export_dt
{% endset %}

{% set results = run_query(fruit_qry) %}
{% do log("Fruit metric loaded", info=True) %}

{% endmacro %}