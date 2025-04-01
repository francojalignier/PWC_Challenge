*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime
Library           XML
Library           Collections
Library           chromedriversync.py
Resource          ../PageObjects/Login.robot
Library           capture_logs.py

*** Variables ***
${Environment}      TEST
${Speed}            0
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
    Set Window Size    1920    969

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
    Validate Element is Visible    ${PageTitle}

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

Validate Button
    [Arguments]    ${ID}
    Element Should Be Visible    btn${ID}

Click Button
    [Arguments]    ${ID}
    Click Element    btn${ID}

Validate Element is Visible
    [Arguments]    ${ID}
    Element Should Be Visible    ${ID}

Validar Toast
    [Arguments]    ${Texto}    ${TimeOut}=20
    Wait Until Element Is Visible    toast-container    ${TimeOut}
    Wait Until Element Is Visible    //*[@id="toast-container"]//*[@aria-label="Close"]
    Element Should Contain    toast-container    ${Texto}
    Click Element    //*[@id="toast-container"]//*[@aria-label="Close"]

Importar Archivo
    [Arguments]    ${Path_Archivo}
    Choose File    name=files[]    ${Path_Archivo}

Validate Required Field
    [Arguments]    ${ID}
    Element Should Be Visible    label${ID}
    Element Should Be Visible    requerido${ID}
    Element Should Be Visible    ${ID}

Fill Input Field
    [Arguments]    ${ID}    ${Valor}
    Wait Until Element Is Visible    ${ID}
    Click Element    ${ID}
    Press Keys    ${ID}    ${Valor}
    Press Keys    none    RETURN

Clean Input Field
    [Arguments]    ${ID}
    Wait Until Element Is Visible    ${ID}
    Click Element    ${ID}
    Clear Element Text    //*[@id="${ID}"]//*[@class="dx-texteditor-input"]
    Press Keys    none    RETURN

Select Value from Dropdown
    [Arguments]    ${ID}    ${Valor}
    Wait Until Element Is Visible    ${ID}
    Click Element    ${ID}
    Sleep    1
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@role="listbox"]//*[@role="option"]//*[contains(text(),'${Valor}')]
    Run Keyword If    ${status}==False    Scroll Element Into View    //*[@role="listbox"]//*[@role="option"]//*[contains(text(),'${Valor}')]
    Click Element    //*[@role="listbox"]//*[@role="option"]//*[contains(text(),'${Valor}')]