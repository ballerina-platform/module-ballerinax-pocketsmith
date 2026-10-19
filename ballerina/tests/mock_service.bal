// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

type ErrorBadRequest record {|
    *http:BadRequest;
    Error body;
|};

listener http:Listener ep0 = new (9090);

function mockInstitution() returns Institution => {
    id: 1001,
    title: "First National Bank",
    currencyCode: "usd",
    createdAt: "2024-01-15T09:30:00Z",
    updatedAt: "2024-03-02T14:05:00Z"
};

function mockTransactionAccount() returns TransactionAccount => {
    id: 2001,
    name: "Everyday Checking",
    number: "****1234",
    'type: "bank",
    currencyCode: "usd",
    currentBalance: 2450.75d,
    currentBalanceInBaseCurrency: 2450.75d,
    currentBalanceDate: "2024-03-01",
    currentBalanceExchangeRate: 1.0d,
    safeBalance: 2000.00d,
    safeBalanceInBaseCurrency: 2000.00d,
    startingBalance: 500.00d,
    startingBalanceDate: "2023-01-01",
    institution: mockInstitution(),
    createdAt: "2024-01-15T09:30:00Z",
    updatedAt: "2024-03-02T14:05:00Z"
};

function mockAccount() returns Account => {
    id: 3001,
    title: "Everyday Checking",
    'type: "bank",
    currencyCode: "usd",
    currentBalance: 2450.75d,
    currentBalanceInBaseCurrency: 2450.75d,
    currentBalanceDate: "2024-03-01",
    currentBalanceExchangeRate: 1.0d,
    safeBalance: 2000.00d,
    safeBalanceInBaseCurrency: 2000.00d,
    isNetWorth: true,
    transactionAccounts: [mockTransactionAccount()],
    createdAt: "2024-01-15T09:30:00Z",
    updatedAt: "2024-03-02T14:05:00Z"
};

function mockCategory() returns Category => {
    id: 4001,
    title: "Groceries",
    colour: "#2ecc71",
    isTransfer: false,
    isBill: false,
    rollUp: false,
    refundBehaviour: "credits_are_refunds",
    createdAt: "2024-01-15T09:30:00Z",
    updatedAt: "2024-03-02T14:05:00Z"
};

function mockTransaction() returns Transaction => {
    id: 5001,
    payee: "Fresh Market",
    originalPayee: "FRESH MARKET #123",
    date: "2024-03-01",
    amount: -54.32d,
    amountInBaseCurrency: -54.32d,
    closingBalance: 2450.75d,
    'type: "debit",
    status: "posted",
    isTransfer: false,
    needsReview: false,
    note: "Weekly groceries",
    memo: "Card purchase",
    labels: ["food", "weekly"],
    category: mockCategory(),
    transactionAccount: mockTransactionAccount(),
    createdAt: "2024-03-01T18:20:00Z",
    updatedAt: "2024-03-01T18:20:00Z"
};

function mockUser() returns User => {
    id: 6001,
    login: "jane.doe",
    name: "Jane Doe",
    email: "jane.doe@example.com",
    avatarUrl: "https://example.com/avatars/jane.png",
    betaUser: false,
    timeZone: "Australia/Sydney",
    weekStartDay: 1,
    baseCurrencyCode: "usd",
    alwaysShowBaseCurrency: false,
    usingMultipleCurrencies: false,
    availableAccounts: 10,
    availableBudgets: 5,
    isReviewingTransactions: false,
    forecastNeedsRecalculate: false,
    forecastDeferRecalculate: false,
    forecastStartDate: "2024-01-01",
    forecastEndDate: "2034-01-01",
    forecastLastUpdatedAt: "2024-03-01T00:00:00Z",
    forecastLastAccessedAt: "2024-03-01T00:00:00Z",
    lastLoggedInAt: "2024-03-02T08:00:00Z",
    lastActivityAt: "2024-03-02T08:30:00Z",
    createdAt: "2023-01-01T00:00:00Z",
    updatedAt: "2024-03-02T08:30:00Z"
};

function mockEvent() returns Event => {
    id: "7001-20240315",
    date: "2024-03-15",
    amount: -1200.00d,
    amountInBaseCurrency: -1200.00d,
    currencyCode: "usd",
    colour: "#e74c3c",
    note: "Monthly rent",
    repeatType: "monthly",
    repeatInterval: 1,
    infiniteSeries: true,
    seriesId: 7001,
    seriesStartId: "7001-20240115",
    category: mockCategory()
};

function mockPeriod() returns Period => {
    startDate: "2024-03-01",
    endDate: "2024-03-31",
    currencyCode: "usd",
    current: true,
    forecastAmount: 600.00d,
    actualAmount: 412.50d,
    refundAmount: 0.00d,
    percentageUsed: 68.75d,
    underBudget: true,
    underBy: 187.50d,
    overBudget: false,
    overBy: 0.00d
};

function mockBudgetAnalysis() returns BudgetAnalysis => {
    startDate: "2024-03-01",
    endDate: "2024-03-31",
    currencyCode: "usd",
    totalForecastAmount: 600.00d,
    totalActualAmount: 412.50d,
    averageForecastAmount: 600.00d,
    averageActualAmount: 412.50d,
    totalUnderBy: 187.50d,
    totalOverBy: 0.00d,
    periods: [mockPeriod()]
};

@http:ServiceConfig {
    treatNilableAsOptional: true
}
service / on ep0 {
    # Delete account
    #
    # + id - The unique identifier of the account
    # + return - Success
    resource function delete accounts/[int id]() returns http:NoContent|ErrorForbidden|ErrorNotFound|ErrorUnprocessableEntity {
        return http:NO_CONTENT;
    }

    # Delete category
    #
    # + id - The unique identifier of the category
    # + return - Success
    resource function delete categories/[int id]() returns http:NoContent|ErrorForbidden|ErrorNotFound {
        return http:NO_CONTENT;
    }

    # Delete transaction
    #
    # + id - The unique identifier of the transaction
    # + return - Success
    resource function delete transactions/[int id]() returns http:NoContent|ErrorForbidden|ErrorNotFound {
        return http:NO_CONTENT;
    }

    # Get account
    #
    # + id - The unique identifier of the account
    # + return - The retrieved account
    resource function get accounts/[int id]() returns Account|ErrorForbidden|ErrorNotFound {
        Account account = mockAccount();
        return account;
    }

    # Get category
    #
    # + id - The unique identifier of the category
    # + return - The retrieved category
    resource function get categories/[int id]() returns Category|ErrorForbidden|ErrorNotFound {
        Category category = mockCategory();
        return category;
    }

    # List currencies
    #
    # + return - The retrieved currencies
    resource function get currencies() returns Currency[] {
        Currency[] currencies = [
            {id: "usd", name: "United States Dollar", symbol: "$", minorUnit: 2, separators: {major: ",", minor: "."}},
            {id: "eur", name: "Euro", symbol: "€", minorUnit: 2, separators: {major: ".", minor: ","}},
            {id: "nzd", name: "New Zealand Dollar", symbol: "$", minorUnit: 2, separators: {major: ",", minor: "."}}
        ];
        return currencies;
    }

    # Get institution
    #
    # + id - The unique identifier of the institution
    # + return - The retrieved institution
    resource function get institutions/[int id]() returns Institution|ErrorForbidden|ErrorNotFound {
        Institution institution = mockInstitution();
        return institution;
    }

    # Get the authorised user
    #
    # + return - The retrieved authorised user
    resource function get me() returns User|ErrorForbidden {
        User user = mockUser();
        return user;
    }

    # List time zones
    #
    # + return - The retrieved time zones
    resource function get time_zones() returns TimeZone[] {
        TimeZone[] zones = [
            {name: "Sydney", identifier: "Australia/Sydney", formattedName: "(UTC+10:00) Sydney", formattedOffset: "+10:00", utcOffset: 36000, abbreviation: "AEST"},
            {name: "London", identifier: "Europe/London", formattedName: "(UTC+00:00) London", formattedOffset: "+00:00", utcOffset: 0, abbreviation: "GMT"}
        ];
        return zones;
    }

    # Get a transaction
    #
    # + id - The unique identifier of the transaction
    # + return - The retrieved transaction
    resource function get transactions/[int id]() returns Transaction|ErrorForbidden|ErrorNotFound {
        Transaction txn = mockTransaction();
        return txn;
    }

    # Get user
    #
    # + id - The unique identifier of the user
    # + return - The retrieved user
    resource function get users/[int id]() returns User|ErrorForbidden|ErrorNotFound {
        User user = mockUser();
        return user;
    }

    # List accounts in user
    #
    # + id - The unique identifier of the user
    # + return - The retrieved user accounts
    resource function get users/[int id]/accounts() returns Account[]|ErrorForbidden|ErrorNotFound {
        Account[] accounts = [mockAccount()];
        return accounts;
    }

    # Get budget summary for user
    #
    # + id - The unique identifier of the user
    # + period - The period to analyse in
    # + interval - The period interval
    # + startDate - The date to start analysing the budget from
    # + endDate - The date to stop analysing the budget from
    # + return - The retrieved user budget summary
    resource function get users/[int id]/budget_summary("weeks"|"months"|"years"|"event" period, int interval, @http:Query {name: "start_date"} string startDate, @http:Query {name: "end_date"} string endDate) returns BudgetAnalysisPackage[]|ErrorBadRequest|ErrorForbidden|ErrorNotFound {
        BudgetAnalysisPackage[] packages = [
            {
                category: mockCategory(),
                isTransfer: false,
                expense: mockBudgetAnalysis(),
                income: mockBudgetAnalysis()
            }
        ];
        return packages;
    }

    # List categories in user
    #
    # + id - The unique identifier of the user
    # + return - The retrieved user categories
    resource function get users/[int id]/categories() returns Category[]|ErrorForbidden|ErrorNotFound {
        Category[] categories = [mockCategory()];
        return categories;
    }

    # List events in user
    #
    # + id - The unique identifier of the user
    # + startDate - The start date of the period to list events for
    # + endDate - The end date of the period to list events for
    # + return - The retrieved user events
    resource function get users/[int id]/events(@http:Query {name: "start_date"} string startDate, @http:Query {name: "end_date"} string endDate) returns Event[]|ErrorForbidden|ErrorNotFound {
        Event[] events = [mockEvent()];
        return events;
    }

    # List institutions in user
    #
    # + id - The unique identifier of the user
    # + return - The retrieved user institutions
    resource function get users/[int id]/institutions() returns Institution[]|ErrorForbidden|ErrorNotFound {
        Institution[] institutions = [mockInstitution()];
        return institutions;
    }

    # List transactions in user
    #
    # + id - The unique identifier of the user
    # + startDate - Only return transactions on or after this date
    # + endDate - Only return transactions on or before this date
    # + updatedSince - Only return transactions updated since this time
    # + uncategorised - Only return uncategorised transactions when set to 1
    # + 'type - Only return transactions of this type
    # + needsReview - Only return transactions needing review when set to 1
    # + search - Search term to match against transactions
    # + page - Page number of results
    # + return - The retrieved user transactions
    resource function get users/[int id]/transactions(@http:Query {name: "start_date"} string? startDate, @http:Query {name: "end_date"} string? endDate, @http:Query {name: "updated_since"} string? updatedSince, int? uncategorised, "debit"|"credit"? 'type, @http:Query {name: "needs_review"} int? needsReview, string? search, int? page) returns Transaction[]|ErrorBadRequest|ErrorForbidden|ErrorNotFound {
        Transaction[] transactions = [mockTransaction()];
        return transactions;
    }

    # Create a transaction in transaction account
    #
    # + id - The unique identifier of the transaction account
    # + payload - Details of the transaction to create
    # + return - The created transaction
    resource function post transaction_accounts/[int id]/transactions(@http:Payload CreateTransactionRequest payload) returns Transaction|ErrorForbidden|ErrorNotFound|ErrorUnprocessableEntity {
        Transaction txn = mockTransaction();
        return txn;
    }

    # Create an account in user
    #
    # + id - The unique identifier of the user
    # + payload - Details of the account to create
    # + return - The created account
    resource function post users/[int id]/accounts(@http:Payload CreateAccountRequest payload) returns Account|ErrorForbidden|ErrorNotFound|ErrorUnprocessableEntity {
        Account account = mockAccount();
        return account;
    }

    # Create category in user
    #
    # + id - The unique identifier of the user
    # + payload - Details of the category to create
    # + return - The created category
    resource function post users/[int id]/categories(@http:Payload CreateCategoryRequest payload) returns Category|ErrorForbidden|ErrorNotFound|ErrorUnprocessableEntity {
        Category category = mockCategory();
        return category;
    }

    # Create institution in user
    #
    # + id - The unique identifier of the user
    # + payload - Details of the institution to create
    # + return - The created institution
    resource function post users/[int id]/institutions(@http:Payload CreateInstitutionRequest payload) returns Institution|ErrorForbidden|ErrorNotFound|ErrorUnprocessableEntity {
        Institution institution = mockInstitution();
        return institution;
    }

    # Update account
    #
    # + id - The unique identifier of the account
    # + payload - Account details to update
    # + return - The updated account
    resource function put accounts/[int id](@http:Payload UpdateAccountRequest payload) returns Account|ErrorForbidden|ErrorNotFound|ErrorUnprocessableEntity {
        Account account = mockAccount();
        return account;
    }

    # Update category
    #
    # + id - The unique identifier of the category
    # + payload - Category details to update
    # + return - The updated category
    resource function put categories/[int id](@http:Payload UpdateCategoryRequest payload) returns Category|ErrorForbidden|ErrorNotFound|ErrorUnprocessableEntity {
        Category category = mockCategory();
        return category;
    }

    # Update a transaction
    #
    # + id - The unique identifier of the transaction
    # + payload - Transaction details to update
    # + return - The updated transaction
    resource function put transactions/[int id](@http:Payload UpdateTransactionRequest payload) returns UpdateTransactionResponse|ErrorForbidden|ErrorNotFound|ErrorUnprocessableEntity {
        Transaction txn = mockTransaction();
        return txn;
    }

    # Update user
    #
    # + id - The unique identifier of the user
    # + payload - User settings to update
    # + return - The updated user
    resource function put users/[int id](@http:Payload UpdateUserRequest payload) returns User|ErrorForbidden|ErrorNotFound|ErrorUnprocessableEntity {
        User user = mockUser();
        return user;
    }
}

// Service-mode response types. `bal openapi --mode client` collapses 4XX/5XX
// to `error` and never emits these, so they are defined here for the mock only.
public type ErrorForbidden record {|
    *http:Forbidden;
    Error body;
|};

public type ErrorNotFound record {|
    *http:NotFound;
    Error body;
|};

public type ErrorUnprocessableEntity record {|
    *http:UnprocessableEntity;
    Error body;
|};

public type Error record {
    # A message describing the error that occurred
    string 'error?;
};
