# Running Tests

## Prerequisites

To run the tests against the live PocketSmith API you need a developer key and a few existing record IDs from your account.

## Test environments

The suite runs against a local mock service by default. Set `IS_LIVE_SERVER=true` to run the live-capable tests against `https://api.pocketsmith.com/v2`.

| Variable | Used for |
|---|---|
| `IS_LIVE_SERVER` | Set to `true` to use the live API instead of the mock service |
| `POCKETSMITH_DEVELOPER_KEY` | Developer key sent in the `X-Developer-Key` header |
| `POCKETSMITH_USER_ID` | ID of the user whose data is listed |
| `POCKETSMITH_INSTITUTION_ID` | ID of an existing institution |
| `POCKETSMITH_TRANSACTION_ACCOUNT_ID` | ID of a transaction account used when creating transactions |

## Running the tests

```bash
# Mock tests (default)
bal test --groups mock_tests

# Live tests
IS_LIVE_SERVER=true POCKETSMITH_DEVELOPER_KEY=<key> POCKETSMITH_USER_ID=<id> \
  POCKETSMITH_INSTITUTION_ID=<id> POCKETSMITH_TRANSACTION_ACCOUNT_ID=<id> \
  bal test --groups live_tests
```

## Test approach

The mock service implements 25 operations covering users, accounts, institutions, transactions, categories, events, budget summaries, currencies and time zones. Read-only operations run in both the `mock_tests` and `live_tests` groups. Operations that create, update or delete data run in `mock_tests` only so that a live account is never modified.
