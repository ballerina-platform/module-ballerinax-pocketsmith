## Overview

[PocketSmith](https://www.pocketsmith.com/) is a personal finance and budgeting platform that brings bank accounts, transactions, categories, budgets and cash-flow forecasts together in one place. This connector supports version 2.0 of the PocketSmith API and lets Ballerina applications read and manage that financial data programmatically.

### Key features

- Manage users, institutions and accounts, including their transaction accounts and balances
- Create, list, update and delete transactions, with filtering by date, type and review status
- Organise spending with categories and category rules
- Analyse budgets, trends and forecast events for a user or scenario
- Look up supported currencies and time zones

## Setup guide

To use the connector you need a PocketSmith account and either a developer key or an OAuth 2.0 access token.

### Option 1: Developer key

1. Sign in to [PocketSmith](https://my.pocketsmith.com/).
2. Open **Settings** and go to **Security & Integrations**, then select **Manage developer keys**.
3. Choose **Create developer key**, give the key a name and copy the generated value. It is shown only once.

### Option 2: OAuth 2.0

1. Register an application in the PocketSmith developer area to obtain a client ID and client secret.
2. Complete the OAuth 2.0 authorization code flow against the PocketSmith authorization and token endpoints to obtain a refresh token.
3. Keep the client ID, client secret and refresh token for the connector configuration.

## Quickstart

To use the `pocketsmith` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/pocketsmith;
```

### Step 2: Instantiate a new connector

Create a `Config.toml` file with your developer key:

```toml
developerKey = "<your-developer-key>"
```

Then create a client in your `.bal` file:

```ballerina
configurable string developerKey = ?;

final pocketsmith:Client pocketsmithClient = check new ({
    auth: {
        xDeveloperKey: developerKey
    }
});
```

### Step 3: Invoke the connector operation

```ballerina
public function main() returns error? {
    pocketsmith:User _ = check pocketsmithClient->getAuthorisedUser();
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `PocketSmith` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-pocketsmith/tree/main/examples/), covering the following use cases:

* [Monthly budget review](https://github.com/ballerina-platform/module-ballerinax-pocketsmith/tree/main/examples/monthly_budget_review/monthly_budget_review.md) - lists a user's accounts and compares forecast and actual spending per category for a date range.
* [Uncategorised transaction cleanup](https://github.com/ballerina-platform/module-ballerinax-pocketsmith/tree/main/examples/uncategorised_transaction_cleanup/uncategorised_transaction_cleanup.md) - finds uncategorised transactions and optionally assigns them to a chosen category.
