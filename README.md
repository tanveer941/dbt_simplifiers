# dbt_simplifiers
Few examples to leverage dbt efficiently and write better code


## Project Overview - examiner

- what does the consolidated view model do?
  - `fruit_basket_consolidated.sql`: Consolidates data from various fruit-related tables/views in the `PLAYGROUND_DB` database.
  - [The packages.yml file](./examiner/packages.yml) has the `dbt_utils` package included, which is used in the `fruit_basket_consolidated.sql` model.
  - The final view created is nothing but a consolidated view of all the fruit-related tables/views in the `PLAYGROUND_DB` database following a particular pattern of schema and table names.
  - To run execute the following commands - ``` dbt deps && dbt run --models fruit_basket_consolidated```

- How does the incremental model work? Show with an example and macro that does this.
  - The [perform_incremental](./examiner/macros/perform_incremental.sql) macro can be leveraged to perform incremental loads.
  - Macro accepts the following parameters:
    - `source_schema`: The source schema from which the data needs to be loaded.
    - `source_table_name`: The source table where the data needs to be loaded.
    - `timestamp_incremental`: The column based on which the incremental load needs to be performed which should of type timestamp.
  - This macro is called in the model file [stream_table_raw.sql](./examiner/models/stream_table/stream_table_raw.sql) to perform incremental loads.
  - The target incremental schema, table name, unique key is to be provided in the config block of the model file. 
  - To run execute the following commands - ``` dbt deps && dbt run --models stream_table_raw```

- Goal is to run a dbt test and capture the failed records in a separate table. 
  - Under normal execution the failed records are rewritten everytime the test is run. Meaning, the records are truncated and then inserted.
  - History of the failed records is not maintained in the table.
  - To enable this feature, we need to override the [test materialization](./examiner/macros/test.sql) implementation for `store_failures` section and append the failed records to the table.
  - The table name is explicitly is mentioned in test materialization implementation because we do not want to proppogate this to other tables.
  - To run execute the following commands - ``` dbt deps && dbt test```

- override test materialization to store failed records in a separate table. Show where to specify the table so that it stores in that table onluy
- how to use the dbt_utils package to write a test that checks if a column is unique
- intentionally fail a test case and show how to do that and save failed records in the table
- write a custom test macro to perform an activity and show how to use it in the test

- How to run simple queries in dbt, iterations, blocks to just give specific results
- run-operation usage
- ```dbt run-operation fruit_table_creation```

- Write a test case for macro
- is_fruit_exist macro and its corresponding test case test_is_fruit_exist