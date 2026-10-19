// Reviews a month of budget performance: resolves the authorised user, lists their
// accounts and analyses forecast against actual spending per category.

import ballerina/io;
import ballerinax/pocketsmith;

configurable string developerKey = ?;
configurable string startDate = ?;
configurable string endDate = ?;

public function main() returns error? {
    pocketsmith:Client pocketsmithClient = check new ({auth: {xDeveloperKey: developerKey}});

    pocketsmith:User user = check pocketsmithClient->getAuthorisedUser();
    int userId = check user?.id.ensureType();
    io:println(string `Reviewing budget for ${user?.name ?: "unknown user"} (id ${userId})`);

    pocketsmith:Account[] accounts = check pocketsmithClient->listUserAccounts(userId);
    string[] scenarioIds = [];
    foreach pocketsmith:Account account in accounts {
        io:println(string `Account: ${account?.title ?: "untitled"} - balance ${account?.currentBalance ?: 0d} ${account?.currencyCode ?: ""}`);
        foreach pocketsmith:Scenario scenario in account?.scenarios ?: [] {
            int? scenarioId = scenario?.id;
            if scenarioId is int {
                scenarioIds.push(scenarioId.toString());
            }
        }
    }

    pocketsmith:Category[] categories = check pocketsmithClient->listUserCategories(userId);
    string[] categoryIds = [];
    collectCategoryIds(categories, categoryIds);
    if categoryIds.length() == 0 || scenarioIds.length() == 0 {
        io:println("No categories or scenarios to analyse");
        return;
    }

    pocketsmith:BudgetAnalysisPackage[] packages = check pocketsmithClient->getUserTrendAnalysis(
        userId, period = "months", interval = 1, startDate = startDate, endDate = endDate,
        categories = string:'join(",", ...categoryIds), scenarios = string:'join(",", ...scenarioIds));
    foreach pocketsmith:BudgetAnalysisPackage budgetPackage in packages {
        string categoryTitle = budgetPackage.category?.title ?: "uncategorised";
        pocketsmith:BudgetAnalysis? expense = budgetPackage.expense;
        if expense is () {
            continue;
        }
        decimal forecast = expense?.totalForecastAmount ?: 0d;
        decimal actual = expense?.totalActualAmount ?: 0d;
        // Expense amounts are debits, so compare spending by magnitude.
        string status = actual.abs() > forecast.abs() ? "over budget" : "within budget";
        io:println(string `${categoryTitle}: forecast ${forecast}, actual ${actual} (${status})`);
    }
}

function collectCategoryIds(pocketsmith:Category[] categories, string[] ids) {
    foreach pocketsmith:Category category in categories {
        int? id = category?.id;
        if id is int {
            ids.push(id.toString());
        }
        collectCategoryIds(category?.children ?: [], ids);
    }
}
