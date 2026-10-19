# Examples

The `ballerinax/pocketsmith` connector provides practical examples illustrating usage in various scenarios.

| Example | Description |
|---|---|
| [monthly_budget_review](./monthly_budget_review/monthly_budget_review.md) | Lists accounts and compares forecast and actual spending per category. |
| [uncategorised_transaction_cleanup](./uncategorised_transaction_cleanup/uncategorised_transaction_cleanup.md) | Finds uncategorised transactions and optionally assigns a category. |

## Prerequisites

1. A PocketSmith developer key for the `ballerinax/pocketsmith` connector. Both examples authenticate with it.
2. A `Config.toml` in each example directory, as described in that example's document.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
