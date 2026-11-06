// Finds uncategorised transactions for the authorised user and, when enabled, assigns
// them to a category chosen by configuration.

import ballerina/io;
import ballerinax/pocketsmith;

configurable string developerKey = ?;
configurable string startDate = ?;
configurable string endDate = ?;
configurable int targetCategoryId = ?;
configurable boolean applyChanges = false;

public function main() returns error? {
    pocketsmith:Client pocketsmithClient = check new ({auth: {xDeveloperKey: developerKey}});

    pocketsmith:User user = check pocketsmithClient->getAuthorisedUser();
    int userId = check user?.id.ensureType();

    int page = 1;
    int found = 0;
    int updated = 0;
    while true {
        pocketsmith:Transaction[] transactions = check pocketsmithClient->listUserTransactions(
            userId, startDate = startDate, endDate = endDate, uncategorised = 1, page = page);
        foreach pocketsmith:Transaction txn in transactions {
            found += 1;
            int txnId = check txn?.id.ensureType();
            io:println(string `Uncategorised: ${txn?.date ?: ""} ${txn?.payee ?: "unknown payee"} ${txn?.amount ?: 0d}`);
            if applyChanges {
                pocketsmith:UpdateTransactionResponse _ = check pocketsmithClient->updateTransaction(txnId, {categoryId: targetCategoryId});
                updated += 1;
            }
        }
        if transactions.length() < 30 {
            break;
        }
        // Categorised transactions drop out of the uncategorised filter, so in update mode
        // the next batch is on page 1 again.
        if !applyChanges {
            page += 1;
        }
    }
    io:println(string `Found ${found} uncategorised transactions, updated ${updated}`);
}
