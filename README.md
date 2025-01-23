# dbt_simplifiers

Few examples to leverage dbt efficiently and write better code.

## Project Overview - examiner

### Consolidated View Model

- **Model**: [`fruit_basket_consolidated.sql`](examiner/models/consolidated/fruit_basket_consolidated.sql)
  - **Description**: Consolidates data from various fruit-related tables/views in the `PLAYGROUND_DB` database.
  - **Dependencies**: The `dbt_utils` package (included in `packages.yml`).
  - **Output**: A consolidated view of all the fruit-related tables/views in the `PLAYGROUND_DB` database following a particular pattern of schema and table names.
  - **Execution**:
    ```sh
    dbt deps && dbt run --models fruit_basket_consolidated
    ```

### Incremental Model

- **Macro**: [`perform_incremental`](examiner/macros/perform_incremental.sql)
  - **Description**: Performs incremental loads.
  - **Parameters**:
    - `source_schema`: The source schema from which the data needs to be loaded.
    - `source_table_name`: The source table where the data needs to be loaded.
    - `timestamp_incremental`: The column based on which the incremental load needs to be performed (should be of type timestamp).
  - **Usage**: Called in the model file [`stream_table_raw.sql`](examiner/models/stream_table/stream_table_raw.sql) to perform incremental loads.
  - **Configuration**: The target incremental schema, table name, and unique key are provided in the config block of the model file.
  - **Execution**:
    ```sh
    dbt deps && dbt run --models stream_table_raw
    ```

### DBT Test with Failure Records

- **Goal**: Run a dbt test and capture the failed records in a separate table.
  - **Behavior**: Under normal execution, the failed records are rewritten every time the test is run (records are truncated and then inserted). History of the failed records is not maintained.
  - **Implementation**: Override the [`test materialization`](examiner/macros/test.sql) implementation for the `store_failures` section to append the failed records to the table.
  - **Note**: The table name is explicitly mentioned in the test materialization implementation to avoid propagation to other tables.
  - **Execution**:
    ```sh
    dbt deps && dbt test
    ```

### Running Queries

- **Goal**: Run a query to perform an operation (select, update, or insert) and test whether the macro works as expected.
  - **Example**: To create a table, execute the command:
    ```sh
    dbt run-operation fruit_table_creation
    ```
  - **File**: The logic is defined in [`fruit_table_creation.sql`](examiner/models/consolidated/fruit_table_creation.sql).

### Unit Testing Macros

- **Macro**: [`is_fruit_exist`](examiner/macros/is_fruit_exist.sql)
  - **Description**: Checks whether the fruit exists in the table or not.
  - **Test Case**: [`test_is_fruit_exist`](examiner/macros/test_macros/test_is_fruit_exist.sql)
  - **Execution**:
    ```sh
    dbt deps && dbt run-operation test_is_fruit_exist
    ```