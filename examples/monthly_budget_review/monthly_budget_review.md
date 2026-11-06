# Monthly budget review

This example resolves the authorised PocketSmith user, lists their accounts with current balances, and summarises budget performance per category for a chosen date range. Each category is reported as within or over budget.

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
  ```

## Run the example

```bash
bal run
```
