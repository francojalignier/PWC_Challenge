*** Settings ***
Resource          ../PageObjects/Login.robot
Resource          ../PageObjects/Menu.robot
Resource          ../Common/Keywords.robot

*** Test Cases ***
Logout
    Run Browser
    Input Text    ${UsernameField}    ${ValidUsername}
    Input Password    ${PasswordField}    ${ValidPassword}
    Click Object    ${LoginButton}
    Click Object    ${MenuButton}
    Click Object    ${LogOutOption}
    Validate Element is Visible    ${UsernameField}
    Validate Element is Visible    ${PasswordField}