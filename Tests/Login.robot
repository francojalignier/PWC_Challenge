*** Settings ***
Resource          ../PageObjects/Login.robot
Resource          ../Common/Keywords.robot
Resource          ../PageObjects/Inventory.robot

*** Test Cases ***
Valid Login
    Run Browser
    Input Text    ${UsernameField}    ${ValidUsername}
    Input Password    ${PasswordField}    ${ValidPassword}
    Click Element    ${LoginButton}
    Validate Element is Visible    ${PageTitle}
    Validate Element is Visible    ${CartButton}
    Validate Element is Visible    ${InventoryList}

Invalid Login - Wrong Username
    Run Browser
    Input Text    ${UsernameField}    ${InvalidUsername}
    Input Password    ${PasswordField}    ${ValidPassword}
    Click Element    ${LoginButton}
    Validate Element is Visible    ${ErrorMessage}

Invalid Login - Wrong Password
    Run Browser
    Input Text    ${UsernameField}    ${ValidUsername}
    Input Password    ${PasswordField}    ${InvalidPassword}
    Click Element    ${LoginButton}
    Validate Element is Visible    ${ErrorMessage}