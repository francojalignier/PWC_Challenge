*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime
Library           XML
Library           Collections
Library           chromedriversync.py
Resource          ../PageObjects/Login.robot
Resource          Variables.robot
Library           capture_logs.py

*** Variables ***
${Environment}      TEST
${Speed}            2
${Url}              https://www.saucedemo.com/
${Browser}          Chrome
${Wait}             2

*** Keywords ***
Parse XML
    ${root}=    XML.Parse Xml    ././Settings.xml
    Should Be Equal    ${root.tag}    Variables
    ${browser}=    Get Element Text    ${root}    ${Environment}/VariableCase[@id='browser']
    ${url}=    Get Element Text    ${root}    ${Environment}/VariableCase[@id='url']
    ${speed}=    Get Element Text    ${root}    ${Environment}/VariableCase[@id='speed']
    ${wait}=    Get Element Text    ${root}    ${Environment}/VariableCase[@id='wait']
    Set Global Variable    ${Url}    ${url}
    Set Global Variable    ${Browser}    ${browser}
    Set Global Variable    ${Speed}    ${speed}
    Set Global Variable    ${Wait}    ${wait}
    ${chromedriver_path}=   chromedriversync.Get Chromedriver Path

Run Browser
    Set Selenium Speed    ${Speed}
    Run Keyword If    "${Browser}"=="chrome"    Chrome
    # Run Keyword If    "${Browser}"=="firefox"    FirefoxHeadless
    Run Keyword If    "${Browser}"=="chromeheadless"    ChromeHeadless

Chrome
    [Documentation]    Realiza la ejecución del Chrome en modo visible.
    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome options}    add_argument    --lang\=es-mx
    ${options}=    Call Method    ${chrome options}    to_capabilities
    Open Browser    ${Url}    chrome    desired_capabilities=${options}
    Maximize Browser Window

ChromeHeadless
    [Documentation]    Realiza la ejecución del Chrome en modo oculto.
    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome options}    add_argument    --lang\=es-mx
    ${options}=    Call Method    ${chrome options}    to_capabilities
    Open Browser    ${Url}    headlesschrome    desired_capabilities=${options}
    Set Window Size    1920    969

Login
    [Arguments]    ${User}    ${Password}
    Run Browser
    Wait Until Element Is Visible    ${UsernameField}    ${Wait}
    Input Text    ${UsernameField}    ${User}
    Input Password    ${PasswordField}    ${Password}
    Click Element    ${LoginButton}
    Wait Until Element Is Visible   ${PageTitle}    ${Wait}

Logout
    [Arguments]    ${exeption}=None
    Close Browser

Check Console Log
    [Arguments]    ${exeption}=None
    @{log_msg}=    get_selenium_browser_log
    FOR    ${message}    IN    @{log_msg}
        Log    ${message}
        Run Keyword If    "${exeption}"!="None"    Should Contain    ${message}    ${exeption}
    END
    Run Keyword If    "${exeption}"=="None"    Should Be True    "@{log_msg}"=="@{EMPTY}"

Validate Element is Visible
    [Arguments]    ${ID}
    Wait Until Element Is Visible    ${ID}    ${Wait}
    Element Should Be Visible    ${ID}

Add Item to Cart
    [Arguments]    ${InventoryList}    ${ItemName}
    Click Element    //div[@id="${InventoryList}"]//div[text()="${ItemName}"]//parent::a//parent::div//parent::div//button[text()="Add to cart"]

Remove Item from Cart
    [Arguments]    ${InventoryList}    ${ItemName}
    Click Element    //div[@id="${InventoryList}"]//div[text()="${ItemName}"]//parent::a//parent::div//parent::div//button[text()="Remove"]

Validate Error Message
    [Arguments]    ${Message}=None
    Validate Element is Visible    ${ErrorMessage}
    Run Keyword If    "${Message}"!="None"    SeleniumLibrary.Element Text Should Be    ${ErrorMessage}    ${Message}
