# Behaviour Driven Development (BDD) Testing Challenge
Resource: [E-commerce Demo Web Application](https://www.saucedemo.com/)

Welcome to the BDD Testing Automation Challenge, please read the instructions below carefully. 

There are two tasks to complete in this challenge.
All tasks are expected to be completed using the web application provided under the Resource link.

You are expected to submit your attempt to your repository and a link to your repository by the time and date specified in the email you have received.

## TASK 1. Manual Testing 

You are required to perform Manual Testing on the [e-commerce web application](https://www.saucedemo.com/) given for task 1.

Please navigate to the link above and familiarize yourself with the behavior and workflow of the web application.
Next, start performing a few manual testing on the core functionalities of the system.

Your task is to **create five crucial test cases and document them in the [Test Plan](task1_manual_test/swaglabs_test_plan.xlsx) provided.**

## TASK 2. Automated Testing

You are required to perform Automated Testing on the [e-commerce web application](https://www.saucedemo.com/) given for task 2.

Given 3 test scenarios below, please create a working automation test script for the specified scenarios using Behaviour Driven Development (BDD) with your choice of automation framework. 
We strongly suggest using Robot Framework. If you attempted this task with other automation framework, please include the instructions to run your test in a new README file.
Installation guide and resources for Robot is specified in the below section. 

Your task is to **automate the following test scenarios**:

    Scenario 1: Verify Cart Checkout
    Scenario 2: Verify Add all product and remove product
    Scenario 3: Verify Product Sorting/Filtering

Please include your script in the [tests](task2_automated_test/tests/) folder.


# Setting up test environment

1. Install robotframework

    If you already have [Python](https://www.python.org/) with [pip](https://pip.pypa.io/en/stable/) installed, you can simply run:
    
    ``` 
    pip install robotframework 
    ```
2. Install chromedriver and export to PATH

    See: https://chromedriver.chromium.org/downloads

## Creating Test Case
Below is a simple test case to test the login function. See [example test case](task2_automated_test/tests/test.robot).

```
*** Test Cases ***
Verify Login
    [Tags]  authentication
    GIVEN Open Browser and Navigate To Page
    WHEN Input Username
    AND Input Password
    AND Submit Credentials
    THEN Welcome Page Should Be Open
    [Teardown]    Close Browser
```

## Creating Robot Keywords
A Robot keyword is the foundation of a robot script. They can be customised to perform a test step in robot test. 
Usage of predefined keywords in libraries such as [Selenium Library](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html) is allowed.
Here are a few example of customised keywords and their step definitions defined in [resource file](task2_automated_test/resources/resource.robot).

```
*** Keywords ***
Open Browser and Navigate To Page
    ${options}    Get Chrome Options
    Open Browser    browser=chrome    options=${options}
    Go to    ${BASE_URL}

Input Username
    Input Text  user-name   standard_user

Input Password
    Input Text  password    secret_sauce

Submit Credentials
    Click Button    login-button

Welcome Page Should Be Open
    Location Should Be    ${BASE_URL}/inventory.html
    Title Should Be     ${TITLE}
```

For more information on creating custom keywords, please refer:
https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#creating-user-keywords

## Usage 

To run all tests in the testing suite use the command:
```
robot task2_automated_test/tests
```

### Documentation
See: https://github.com/robotframework/robotframework#id8
