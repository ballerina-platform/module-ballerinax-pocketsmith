# Uncategorised transaction cleanup

This example pages through the authorised user's uncategorised transactions for a date range and prints each one. When `applyChanges` is set to `true`, it also assigns every transaction to the configured category.

## Prerequisites

- Ballerina Swan Lake 2201.x or later
- Push the connector to the local repository:
  ```bash
  cd ballerina
  bal pack && bal push --repository=local
  ```
- Create a `Config.toml` in this directory:
  ```toml
  developerKey = "<your-developer-key>"
  startDate = "2024-03-01"
  endDate = "2024-03-31"
  targetCategoryId = 12345
  applyChanges = false
  ```

## Run the example

```bash
bal run
```
