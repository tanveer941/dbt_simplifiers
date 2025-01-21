{%- materialization test, default -%}

  {% set relations = [] %}

  {% if should_store_failures() %}

    {% set identifier = model['alias'] %}
    {{ log("identifier:: " ~ identifier_table) }}

        {% set old_relation = adapter.get_relation(database=database, schema=schema, identifier=identifier) %}
        {% set target_relation = api.Relation.create(
            identifier=identifier, schema=schema, database=database, type='table') -%} %}
        {% set tmp_identifier = "temp_" ~ target_relation.identifier %}
        {% set tmp_relation = api.Relation.create(
            identifier=tmp_identifier, schema=schema, database=database, type='table') -%} %}

        {% if old_relation and identifier == 'fruit_duplicate_log'%}
            {% set build_sql =  build_append_only_sql(target_relation, tmp_relation) %}
        {% else %}
            {%- set build_sql =  build_append_only_initial_sql(target_relation, tmp_relation) %}
        {% endif %}

        {% call statement(auto_begin=True) %}
            {{ build_sql }}
        {% endcall %}

        {% do relations.append(target_relation) %}

        {% set main_sql %}
            select *
            from {{ target_relation }}
        {% endset %}

        {{ adapter.commit() }}

      {% else %}

          {% set main_sql = sql %}

  {% endif %}

  {% set limit = config.get('limit') %}
  {% set fail_calc = config.get('fail_calc') %}
  {% set warn_if = config.get('warn_if') %}
  {% set error_if = config.get('error_if') %}

  {% call statement('main', fetch_result=True) -%}

    {{ get_test_sql(main_sql, fail_calc, warn_if, error_if, limit)}}

  {%- endcall %}

  {{ return({'relations': relations}) }}

{%- endmaterialization -%}

{%- macro build_append_only_initial_sql(target_relation, temp_relation) -%}
    {{ create_table_as(True, temp_relation, sql) }}
    {%- set initial_sql -%}
        SELECT * ,TO_VARCHAR(current_timestamp(),'yyyymmdd-hhmiss') as execution_id
        FROM {{ temp_relation }}
    {%- endset -%}
    {{ create_table_as(False, target_relation, initial_sql) }}
{%- endmacro -%}

{%- macro build_append_only_sql(target_relation, temp_relation) -%}
    {%- set columns = adapter.get_columns_in_relation(target_relation) -%}
    {%- set csv_colums = get_quoted_csv(columns | map(attribute="name")) %}
    {{ create_table_as(True, temp_relation, sql) }}
    INSERT into {{ target_relation }} ({{ csv_colums }})
    SELECT *, TO_VARCHAR(current_timestamp(),'yyyymmdd-hhmiss') as execution_id
    FROM {{ temp_relation }}
{%- endmacro -%}
