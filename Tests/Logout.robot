*** Settings ***
Resource          ../PageObjects/Login.robot
Resource          ../PageObjects/Menu.robot
Resource          ../Common/Keywords.robot

*** Test Cases ***
Logout
    Run Browser
    Input Text    ${UsernameField}    ${ValidUsername}
    Input Password    ${PasswordField}    ${ValidPassword}
    Click Element    ${LoginButton}
    Validate Element is Visible    ${MenuButton}
    Click Element    ${MenuButton}
    Validate Element is Visible    ${LogOutOption}
    Click Element    ${LogOutOption}
    Validate Element is Visible    ${UsernameField}
    Validate Element is Visible    ${PasswordField}