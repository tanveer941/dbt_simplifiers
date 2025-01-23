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

- Goal is to simply run a query to perform an operation. It may be select, update or insert. Also, perform test whether the macro works as expected.
  - To create a table simply execute the command ```dbt run-operation fruit_table_creation``` It will run the logic defined in the [fruit_table_creation.sql](./examiner/operations/fruit_table_creation.sql) file.


- Goal is to perform a simple unit test on the macro.
  - The macro [is_fruit_exist](./examiner/macros/is_fruit_exist.sql) is created to check whether the fruit exists in the table or not.
  - The test case [test_is_fruit_exist](./examiner/macros/test_macros/test_get_fruit_id.sql) is created to test the macro.
  - To run execute the following commands - ``` dbt deps && dbt run-operation test_is_fruit_exist```