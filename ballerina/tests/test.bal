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
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.pocketsmith.com/v2" : "http://localhost:9090";
final string developerKey = isLiveServer ? os:getEnv("POCKETSMITH_DEVELOPER_KEY") : "test_developer_key";
final int userId = isLiveServer ? check int:fromString(os:getEnv("POCKETSMITH_USER_ID")) : 6001;
final int institutionId = isLiveServer ? check int:fromString(os:getEnv("POCKETSMITH_INSTITUTION_ID")) : 1001;
final int transactionAccountId = isLiveServer ? check int:fromString(os:getEnv("POCKETSMITH_TRANSACTION_ACCOUNT_ID")) : 2001;

final Client pocketsmith = check new ({auth: {xDeveloperKey: developerKey}, httpVersion: http:HTTP_1_1}, serviceUrl);

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetAuthorisedUser() returns error? {
    User user = check pocketsmith->getAuthorisedUser();
    test:assertTrue(user?.id !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetUser() returns error? {
    User user = check pocketsmith->getUser(userId);
    test:assertTrue(user?.login !is ());
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testUpdateUser() returns error? {
    User user = check pocketsmith->updateUser(userId, {name: "Jane Doe"});
    test:assertTrue(user?.id !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListUserAccounts() returns error? {
    Account[] accounts = check pocketsmith->listUserAccounts(userId);
    test:assertTrue(accounts.length() >= 0);
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testCreateUserAccount() returns error? {
    Account account = check pocketsmith->createUserAccount(userId, {
        title: "Everyday Checking",
        'type: "bank",
        currencyCode: "usd",
        institutionId
    });
    test:assertTrue(account?.id !is ());
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testGetAccount() returns error? {
    Account account = check pocketsmith->getAccount(3001);
    test:assertTrue(account?.title !is ());
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testUpdateAccount() returns error? {
    Account account = check pocketsmith->updateAccount(3001, {title: "Renamed Checking"});
    test:assertTrue(account?.id !is ());
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testDeleteAccount() returns error? {
    Account account = check pocketsmith->createUserAccount(userId, {
        title: "Temporary Account",
        'type: "bank",
        currencyCode: "usd",
        institutionId
    });
    check pocketsmith->deleteAccount(check account?.id.ensureType());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListUserTransactions() returns error? {
    Transaction[] transactions = check pocketsmith->listUserTransactions(userId);
    test:assertTrue(transactions.length() >= 0);
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testCreateTransactionAccountTransaction() returns error? {
    Transaction txn = check pocketsmith->createTransactionAccountTransaction(transactionAccountId, {
        payee: "Fresh Market",
        date: "2024-03-01",
        amount: -54.32d
    });
    test:assertTrue(txn?.id !is ());
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testGetTransaction() returns error? {
    UpdateTransactionResponse|error updated = pocketsmith->updateTransaction(5001, {note: "Updated note"});
    test:assertTrue(updated is Transaction);
    Transaction|error txn = pocketsmith->getTransaction(5001);
    test:assertTrue(txn is Transaction);
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testDeleteTransaction() returns error? {
    Transaction txn = check pocketsmith->createTransactionAccountTransaction(transactionAccountId, {
        payee: "Temporary Payee",
        date: "2024-03-01",
        amount: -1.00d
    });
    check pocketsmith->deleteTransaction(check txn?.id.ensureType());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListUserCategories() returns error? {
    Category[] categories = check pocketsmith->listUserCategories(userId);
    test:assertTrue(categories.length() >= 0);
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testCreateUserCategory() returns error? {
    Category category = check pocketsmith->createUserCategory(userId, {title: "Groceries"});
    test:assertTrue(category?.id !is ());
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testGetCategory() returns error? {
    Category category = check pocketsmith->getCategory(4001);
    test:assertTrue(category?.title !is ());
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testUpdateCategory() returns error? {
    Category category = check pocketsmith->updateCategory(4001, {title: "Food"});
    test:assertTrue(category?.id !is ());
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testDeleteCategory() returns error? {
    Category category = check pocketsmith->createUserCategory(userId, {title: "Temporary Category"});
    check pocketsmith->deleteCategory(check category?.id.ensureType());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListUserInstitutions() returns error? {
    Institution[] institutions = check pocketsmith->listUserInstitutions(userId);
    test:assertTrue(institutions.length() >= 0);
}

@test:Config {groups: ["mock_tests"], enable: !isLiveServer}
function testCreateUserInstitution() returns error? {
    Institution institution = check pocketsmith->createUserInstitution(userId, {title: "First National Bank", currencyCode: "usd"});
    test:assertTrue(institution?.id !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetInstitution() returns error? {
    Institution institution = check pocketsmith->getInstitution(institutionId);
    test:assertTrue(institution?.title !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListUserEvents() returns error? {
    Event[] events = check pocketsmith->listUserEvents(userId, startDate = "2024-03-01", endDate = "2024-03-31");
    test:assertTrue(events.length() >= 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetUserBudgetSummary() returns error? {
    BudgetAnalysisPackage[] packages = check pocketsmith->getUserBudgetSummary(userId, period = "months", interval = 1, startDate = "2024-03-01", endDate = "2024-03-31");
    test:assertTrue(packages.length() >= 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListCurrencies() returns error? {
    Currency[] currencies = check pocketsmith->listCurrencies();
    test:assertTrue(currencies.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListTimeZones() returns error? {
    TimeZone[] zones = check pocketsmith->listTimeZones();
    test:assertTrue(zones.length() > 0);
}
