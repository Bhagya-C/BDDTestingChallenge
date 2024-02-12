*** Settings ***
Documentation     A test suite to test the functionality of saucedemo.com online portal
Resource          ../resources/resource.robot
Library           SeleniumLibrary
Library           Collections
Test Teardown     Close All Browsers

*** Variables ***
${username}    standard_user
${password}    secret_sauce

*** Test Cases ***

Verify user is able to complete the checkout process successfully
    [Setup]    Login    ${username}    ${password}
    Given User has added all items to the cart
    When User proceeds to cart
    And User proceeds to checkout
    Then User should be able to fill the shipping information
    And User should be able to view the checkout overview page
    When User proceeds to finish the checkout process
    Then Verify Successful Checkout
    [Teardown]    Logout

Verify Add all products and remove products from cart
    [Setup]    Login    ${username}    ${password}
    Given User has added all items to the cart
    Then Get the item count from the cart badge
    Then Verify that the item count on the cart badge is 6
    When User proceeds to cart
    Then User should see the checkout page
    And User should see all items in the cart 
    Then User able to remove products from cart
    Then Verify that there are no items on the cart badge
    [Teardown]    Logout

Verify product sorting in price(high to low) order
    [Setup]    Login    ${username}    ${password}
    Given User is on product page
    Then User should be able to sort the products in price(high to low) order
    [Teardown]    Logout

Verify product sorting in price(low to high) order
    [Setup]    Login    ${username}    ${password}
    Given User is on product page
    Then User should be able to sort the products in price(low to high) order
    [Teardown]    Logout

#And User should be able to complete the checkout process successfully  

*** Keywords ***
User is logged in
    [Arguments]    ${username}    ${password}
    Login    ${username}    ${password}

User is on product page
    Location Should Be      ${BASE_URL}/inventory.html
    Title Should Be         ${TITLE}

User has added all items to the cart
    Wait Until Page Contains Element    css:.inventory_item_name
    ${items}    Get WebElements    css:.btn_inventory
    FOR    ${item}    IN    @{items}
        Click Element    ${item}
    END

Get the item count from the cart badge
    ${badge_count}    Get Text    css:span.shopping_cart_badge

Verify that the item count on the cart badge is 6
    ${badge_number}    Get Text    css:span.shopping_cart_badge
    Should Be Equal As Numbers    ${badge_number}    6  

User proceeds to cart
    Click Element    css:.shopping_cart_link
    ${cart_header}    Get Text    css:.header_secondary_container
    Should Be Equal As Strings    Your Cart    ${cart_header}


User should see the checkout page
    Location Should Be      ${BASE_URL}/cart.html
    Title Should Be         ${TITLE}

User should see all items in the cart
    ${item_count}    Get Length    6

User able to remove products from cart
    ${remove_buttons}    Get WebElements    xpath://button[contains(text(), 'Remove')]
    FOR    ${button}    IN    @{remove_buttons}
        Click Element    ${button}
    END

Verify that there are no items on the cart badge
    Page Should Not Contain Element    css:#shopping_cart_badge

User proceeds to checkout  
    Click Element    id:checkout

User should be able to fill the shipping information
    Input Text    id:first-name    Bhagya
    Input Text    id:last-name    Chintagunta
    Input Text    id:postal-code    3000
    Click Element    id:continue

User should be able to view the checkout overview page
    Location Should Be      ${BASE_URL}/checkout-step-two.html
    ${actual_header}    Get Text    css:.header_secondary_container
    Should Be Equal As Strings    Checkout: Overview    ${actual_header}

User proceeds to finish the checkout process
    Click Button    id:finish

Verify Successful Checkout
    Location Should Be      ${BASE_URL}/checkout-complete.html
    ${actual_header}    Get Text    css:.header_secondary_container
    Should Be Equal As Strings    Checkout: Complete!   ${actual_header}
    ${success_text}    Get Text    css:.complete-header
    Should Be Equal As Strings    Thank you for your order!   ${success_text}

User should be able to sort the products in price(high to low) order
    Click Element    css:.product_sort_container
    Choose sort option    Price (high to low)
    ${actual_price_list}=  Get all actual price item values
    ${expected_price_List}=    Create List    $49.99    $29.99    $15.99    $15.99    $9.99    $7.99
    Verify sorted prices match in order    ${expected_price_list}    actual_price_list=${actual_price_list}

User should be able to sort the products in price(low to high) order
    Click Element    css:.product_sort_container
    Choose sort option    Price (low to high)
    ${actual_price_list}=  Get all actual price item values
    ${expected_price_List}=    Create List    $7.99    $9.99    $15.99    $15.99    $29.99    $49.99
    Verify sorted prices match in order    ${expected_price_list}    actual_price_list=${actual_price_list}

Choose sort option
    [Arguments]    ${option}
    Select From List By Label    css:.product_sort_container    ${option}

Get all actual price item values
    ${actual_price_list}=    Create List
    ${price_elements}    Get WebElements    css:.inventory_item_price
    FOR    ${price_locator}    IN    @{price_elements}
        ${price}=    Get Text    ${price_locator}
        Append To List    ${actual_price_list}    ${price}
    END
    [Return]    ${actual_price_list}
    
Verify sorted prices match in order
    [Arguments]    ${expected_price_List}    ${actual_price_list}
    Should Be Equal     ${actual_price_list}    ${expected_price_List} 


    