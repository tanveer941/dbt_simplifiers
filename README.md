# dbt_simplifiers
Few examples to leverage dbt efficiently and write better code


## examiner

- under the macros folder
- under the packages.yml
- under the models folder
- what does the consolidated view model do?
- how does the incremental model work? show with an example and macro that does this. the stream table raw model

- override test materialization to store failed records in a separate table. Show where to specify the table so that it stores in that table onluy
- how to use the dbt_utils package to write a test that checks if a column is unique
- intentionally fail a test case and show how to do that and save failed records in the table
- write a custom test macro to perform an activity and show how to use it in the test

- How to run simple queries in dbt, iterations, blocks to just give specific results
- run-operation usage
- ```dbt run-operation fruit_table_creation```

- Write a test case for macro
- is_fruit_exist macro and its corresponding test case test_is_fruit_exist