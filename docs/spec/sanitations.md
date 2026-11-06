_Author_:  @DimuthuMadushan \
_Created_: 2026/10/19 \
_Updated_: 2026/10/19 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from PocketSmith. 
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/pocketsmith/pocketsmith/2.0/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. Change `CreateCategoryRequest refund_behaviour` to nullable
- **Original**: The `refund_behaviour` field in `CreateCategoryRequest` was `not nullable`.
- **Updated**: The `refund_behaviour` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

2. Change `UpdateCategoryRequest refund_behaviour` to nullable
- **Original**: The `refund_behaviour` field in `UpdateCategoryRequest` was `not nullable`.
- **Updated**: The `refund_behaviour` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

3. Rewrite generic `Success` response descriptions that carry a body
- **Original**: 46 responses with a body were described only as `Success`.
- **Updated**: Each now names what is returned (for example `The retrieved user accounts`), derived from the operation. `Success` is kept on no-content responses.
- **Reason**: `Success` is uninformative for a typed response and ends up as the return doc comment in the generated client.
- **Note**: Applied to the aligned spec by `tooling/sanitize_spec.py`, not to the original; it must be re-applied after a re-align.

4. Describe the `assignTransactionAttachment` 201 response
- **Original**: The `201` response of `POST /transactions/{id}/attachments` was described only as `Success`.
- **Updated**: The description reads `The attachment assigned to the transaction`.
- **Reason**: `Success` is uninformative for a typed response. This change was made in the original spec `docs/spec/openapi.json`.

5. Require both fields of the split-transaction response
- **Original**: The split alternative of the `PUT /transactions/{id}` `200` response (`TransactionSplitsResponse`) had no required properties.
- **Updated**: `transaction` and `split_transactions` are required.
- **Reason**: With every field optional, the split response cannot be told apart from a plain `Transaction`. This change was made in the original spec `docs/spec/openapi.json`.

6. List `TransactionSplitsResponse` first in `UpdateTransactionResponse`
- **Original**: The `oneOf` of `UpdateTransactionResponse` listed `Transaction` before `TransactionSplitsResponse`.
- **Updated**: `TransactionSplitsResponse` is listed first.
- **Reason**: Ballerina binds a union to its first matching member, and `Transaction` is an open record that also accepts a split response. With the split alternative first and its fields required (item 5), a split response binds to `TransactionSplitsResponse` and a plain transaction falls through to `Transaction`.
- **Note**: Made in the aligned spec only, because the flattener names the inline schema by its position (`InlineResponse200OneOf2` in `ai-mappings.json`), so reordering the original would lose the name. It must be re-applied after a re-align.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json --mode client --license docs/license.txt -o ballerina --client-methods remote
```

Note: The license year is hardcoded to 2024, change if necessary.
