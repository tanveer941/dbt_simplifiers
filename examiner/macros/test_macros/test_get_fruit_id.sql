{% macro test_is_fruit_exist() %}
     {# Testcase to fetch a fruit that exists #}
     {% set results = is_fruit_exist(fruit_name= 'apple') %}
     {{ dbt_unittest.assert_equals(results, true) }}

     {# Testcase to fetch a fruit that does not exists #}
     {% set results = is_fruit_exist(fruit_name= 'dragonfruit')  %}
     {{ dbt_unittest.assert_equals(results, false) }}

{% endmacro %}