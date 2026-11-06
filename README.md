# Ballerina PocketSmith connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-pocketsmith/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-pocketsmith/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-pocketsmith.svg)](https://github.com/ballerina-platform/module-ballerinax-pocketsmith/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/pocketsmith.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fpocketsmith)

## Overview

[PocketSmith](https://www.pocketsmith.com/) is a personal finance and budgeting platform that brings bank accounts, transactions, categories, budgets and cash-flow forecasts together in one place. This connector supports version 2.0 of the PocketSmith API and lets Ballerina applications read and manage that financial data programmatically.

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

* [Monthly budget review](examples/monthly_budget_review/monthly_budget_review.md) - lists a user's accounts and compares forecast and actual spending per category for a date range.
* [Uncategorised transaction cleanup](examples/uncategorised_transaction_cleanup/uncategorised_transaction_cleanup.md) - finds uncategorised transactions and optionally assigns them to a chosen category.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`pocketsmith` package](https://central.ballerina.io/ballerinax/pocketsmith/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
