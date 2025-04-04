*** Settings ***
Resource          ../Common/Keywords.robot
Resource          ../PageObjects/Inventory.robot
Resource          ../PageObjects/Cart.robot

*** Variables ***
@{ItemsList}    Sauce Labs Backpack    Sauce Labs Bike Light    Sauce Labs Bolt T-Shirt    Sauce Labs Fleece Jacket    Sauce Labs Onesie    
...    Test.allTheThings() T-Shirt (Red)

*** Test Cases ***
Add all items to Cart manually
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    FOR    ${Item}    IN    @{ItemsList}
        Add Item to Cart    ${InventoryList}    ${Item}
    END
    Validate Cart Number    ${CartBadge}

Add all items to Cart automatically
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    @{Items}=    Get WebElements   ${AddToCartButton}
    FOR    ${Item}    IN    @{Items}
        Click Element    ${Item}
    END
    Validate Cart Number    ${CartBadge}
    

Add first item to Cart manually
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    Add Item to Cart    ${InventoryList}    ${ItemsList}[0]
    Validate Cart Number    ${CartBadge}

Add first item to Cart automatically
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    @{Items}=    Get WebElements   ${AddToCartButton}
    Click Element    ${Items}[0]
    Validate Cart Number    ${CartBadge}

Add all items to Cart and remove the first
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    @{Items}=    Get WebElements   ${AddToCartButton}
    FOR    ${Item}    IN    @{Items}
        Click Element    ${Item}
    END
    @{ItemsToBeRemoved}=    Get WebElements   ${RemoveFromCartButton}
    Click Element    ${ItemsToBeRemoved}[1]
    Validate Cart Number    ${CartBadge}

Sort Products by Price (Low-High)
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    Select From List By Value    ${SortByDropdown}    ${SortLowtoHigh_Option}
    ${Prices}    Create List
    @{InventoryItems}=    Get WebElements   ${InventoryItemPrice}
    FOR    ${item}    IN    @{InventoryItems}
        ${Price}    Get String and return Number    ${item}    $
        Append To List    ${Prices}    ${Price}
    END
    ${SortedPrices}    Copy List    ${Prices}
    Sort List    ${SortedPrices}
    Lists Should Be Equal    ${Prices}    ${SortedPrices}

Sort Products by Price (High-Low)
    Login    ${ValidUsername}    ${ValidPassword}
    Wait Until Element Is Visible    ${InventoryList}
    Select From List By Value    ${SortByDropdown}    ${SortHightoLow_Option}
    Sleep    1
    ${Prices}    Create List
    @{InventoryItems}=    Get WebElements   ${InventoryItemPrice}
    FOR    ${item}    IN    @{InventoryItems}
        ${Price}    Get String and return Number    ${item}    $
        Append To List    ${Prices}    ${Price}
    END
    ${SortedPrices}    Copy List    ${Prices}
    Sort List    ${SortedPrices}
    Reverse List    ${SortedPrices}
    Lists Should Be Equal    ${Prices}    ${SortedPrices}

*** Keywords ***
Validate Cart Number
    [Arguments]    ${ID}
    Wait Until Element Is Visible    ${ID}
    @{Items}=    Get WebElements   ${RemoveFromCartButton}
    ${Amount}=    Get Length    ${Items}
    SeleniumLibrary.Element Text Should Be    ${ID}    ${Amount}