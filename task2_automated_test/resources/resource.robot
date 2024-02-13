*** Settings ***
Library           SeleniumLibrary
Library           ./chrome_options.py

*** Variables ***
${BASE_URL}=   https://www.saucedemo.com
${TITLE}=      Swag Labs

*** Keywords ***
Open Browser and Navigate To Page
    ${options} Get Chrome Options
    Open Browser browser=chrome options=${options}
    Go to ${BASE_URL}

Input Username
    Input Text    id:user-name    ${username}

Input Password
    Input Text    id:password       secret_sauce

Submit Credentials
    Click Button    id:login-button

Welcome Page Should Be Open
    Location Should Be      ${BASE_URL}/inventory.html
    Title Should Be         ${TITLE}

Login
    [Arguments]    ${username}    ${password}
    Open Browser    https://www.saucedemo.com    chrome
    Input Username
    Input Password
    Submit Credentials
    Welcome Page Should Be Open

Logout
    ${burger_menu_exists}    Run Keyword And Return Status    Page Should Contain Element    id:react-burger-menu-btn
    Run Keyword If    ${burger_menu_exists}    Click Element    id:react-burger-menu-btn
    ${logout_link_exists}    Run Keyword And Return Status    Page Should Contain Element    xpath://div[@class='bm-item-list']//a[contains(text(), 'Logout')]
    Run Keyword If    ${logout_link_exists}    Click Element    xpath://div[@class='bm-item-list']//a[contains(text(), 'Logout')]
    [Teardown]    Close Browser