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
        Click Element    ${Item}
    END
    Click Element    ${CartButton}
    Validate Element is Visible    ${CheckoutButton}
    Scroll Element Into View    ${CheckoutButton}
    Click Element    ${CheckoutButton}
    Validate Element is Visible    ${FirstNameField}
    Input Text    ${FirstNameField}    Franco
    Input Text    ${LastNameField}    Jalignier
    Input Text    ${PostalCodeField}    2000
    Click Element    ${ContinueButton}
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
    Click Element    ${FinishButton}
    Validate Element is Visible    ${CheckoutCompleted}

Checkout with First Name empty
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    @{Items}=    Get WebElements   ${AddToCartButton}
    FOR    ${Item}    IN    @{Items}
        Click Element    ${Item}
    END
    Click Element    ${CartButton}
    Validate Element is Visible    ${CheckoutButton}
    Scroll Element Into View    ${CheckoutButton}
    Click Element    ${CheckoutButton}
    Validate Element is Visible    ${FirstNameField}
    Input Text    ${LastNameField}    Jalignier
    Input Text    ${PostalCodeField}    2000
    Click Element    ${ContinueButton}
    Validate Error Message    Error: First Name is required

Checkout with Last Name empty
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    @{Items}=    Get WebElements   ${AddToCartButton}
    FOR    ${Item}    IN    @{Items}
        Click Element    ${Item}
    END
    Click Element    ${CartButton}
    Validate Element is Visible    ${CheckoutButton}
    Scroll Element Into View    ${CheckoutButton}
    Click Element    ${CheckoutButton}
    Validate Element is Visible    ${FirstNameField}
    Input Text    ${FirstNameField}    Franco
    Input Text    ${PostalCodeField}    2000
    Click Element    ${ContinueButton}
    Validate Error Message     Error: Last Name is required

Checkout with Postal Code empty
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    @{Items}=    Get WebElements   ${AddToCartButton}
    FOR    ${Item}    IN    @{Items}
        Click Element    ${Item}
    END
    Click Element    ${CartButton}
    Validate Element is Visible    ${CheckoutButton}
    Scroll Element Into View    ${CheckoutButton}
    Click Element    ${CheckoutButton}
    Validate Element is Visible    ${FirstNameField}
    Input Text    ${FirstNameField}    Franco
    Input Text    ${LastNameField}    Jalignier
    Click Element    ${ContinueButton}
    Validate Error Message    Error: Postal Code is required