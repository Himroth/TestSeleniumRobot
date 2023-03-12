*** Settings ***
Library     SeleniumLibrary

*** Variable ***
#Test data
${wrong_name}                           test
${wrong_password}                       test
${login_error_message_front}            ERROR: The username or password you entered is incorrect. Lost your password?
${message_name_mandatory_front}         Este campo é obrigatório. Por favor, preencha com um texto


#Configuration variables
${URL}          https://osagilistas.com/login/
${Browser}      chrome

#Elements
${input_name}                   id:forminator-field-text-1_640e08031f2ca
${input_password}               id:forminator-field-password-1_640e08031f2ca
${button_login}                 //*[@id="forminator-module-17221"]/div[5]/div/div/button
${login_error_message}          //*[@id="forminator-module-17221"]/div[1]/label
${message_name_mandatory}       //*[@id="text-1"]/div/span

*** Keywords ***
the user access the os agilistas website
    Open Browser    ${URL}  ${Browser}

the user fill the field name with a wrong name
    Input Text       ${input_name}      ${wrong_name}

fill the field password with a wrong password
    Input Text      ${input_password}   ${wrong_password}

the user clicks on button login
    Click Element       ${button_login}

the user must see the error message
    Wait Until Element Is Visible       ${login_error_message}
    Wait Until Element Contains         ${login_error_message}       ${login_error_message_front}

the user clicks on the field name
    Click Element       ${input_name}

Then the user must see the warning message about mandatory name field
    Wait Until Element Contains         ${message_name_mandatory}       ${message_name_mandatory_front}


*** Test Cases ***
Scenario 1: Validates if the name field on login is mandatory showing the warning message
    Given the user access the os agilistas website
    And the user clicks on the field name
    When the user clicks on button login
    Then the user must see the warning message about mandatory name field

Scenario 3: Validates if is showed the correctly message when the user tries to login with wrong user and password
    Given the user access the os agilistas website
    And the user fill the field name with a wrong name
    And fill the field password with a wrong password
    When the user clicks on button login
    Then the user must see the error message


