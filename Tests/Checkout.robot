*** Settings ***
Resource          ../Common/Keywords.robot
Resource          ../PageObjects/Inventory.robot
Resource          ../PageObjects/Cart.robot
Resource          ../PageObjects/Checkout.robot
Resource          ../PageObjects/CheckoutSummary.robot

*** Variables ***
${CalculatedPrice}    0

*** Test Cases ***
Successful checkout
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    @{Items}=    Get WebElements   ${AddToCartButton}
    FOR    ${Item}    IN    @{Items}
        Click Object    ${Item}
    END
    Click Object    ${CartButton}
    Click Object    ${CheckoutButton}
    Validate Element is Visible    ${FirstNameField}
    Input Text    ${FirstNameField}    Franco
    Input Text    ${LastNameField}    Jalignier
    Input Text    ${PostalCodeField}    2000
    Click Object    ${ContinueButton}
    Validate Element is Visible    ${CheckoutSummaryList}
    @{SummaryItems}=    Get WebElements   ${ItemPrice}
    FOR    ${Item}    IN    @{SummaryItems}
        ${SinglePrice}=    Get String and return Number    ${Item}    $
        ${CalculatedPrice}=     Evaluate   ${SinglePrice}+${CalculatedPrice}
    END
    Log    ${CalculatedPrice}
    ${Tax}=    Get String and return Number    ${TaxItem}    Tax: $
    Log    ${Tax}
    ${TotalCalculated}=    Evaluate   ${Tax}+${CalculatedPrice}
    ${Total}=    Get String and return Number    ${TotalPrice}    Total: $
    Should Be Equal As Integers    ${Total}    ${TotalCalculated}
    Click Object    ${FinishButton}
    Validate Element is Visible    ${CheckoutCompleted}

Checkout with First Name empty
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    @{Items}=    Get WebElements   ${AddToCartButton}
    FOR    ${Item}    IN    @{Items}
        Click Object    ${Item}
    END
    Click Object    ${CartButton}
    Click Object    ${CheckoutButton}
    Validate Element is Visible    ${FirstNameField}
    Input Text    ${LastNameField}    Jalignier
    Input Text    ${PostalCodeField}    2000
    Click Object    ${ContinueButton}
    Validate Error Message    Error: First Name is required

Checkout with Last Name empty
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    @{Items}=    Get WebElements   ${AddToCartButton}
    FOR    ${Item}    IN    @{Items}
        Click Object    ${Item}
    END
    Click Object    ${CartButton}
    Click Object    ${CheckoutButton}
    Validate Element is Visible    ${FirstNameField}
    Input Text    ${FirstNameField}    Franco
    Input Text    ${PostalCodeField}    2000
    Click Object    ${ContinueButton}
    Validate Error Message     Error: Last Name is required

Checkout with Postal Code empty
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    @{Items}=    Get WebElements   ${AddToCartButton}
    FOR    ${Item}    IN    @{Items}
        Click Object    ${Item}
    END
    Click Object    ${CartButton}
    Click Object    ${CheckoutButton}
    Validate Element is Visible    ${FirstNameField}
    Input Text    ${FirstNameField}    Franco
    Input Text    ${LastNameField}    Jalignier
    Click Object    ${ContinueButton}
    Validate Error Message    Error: Postal Code is required