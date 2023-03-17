*** Settings ***
Library     SeleniumLibrary

*** Variable ***
#Test data login page
${wrong_name}                               test
${wrong_password}                           test
${login_error_message_front}                ERROR: The username or password you entered is incorrect. Lost your password?
${message_name_mandatory_front}             Este campo é obrigatório. Por favor, preencha com um texto
${message_password_mandatory_front}         sua senha é necessária

#Test data register page
${title_register_page_front}                Cadastro - Os Agilistas
${message_mandatory_full_name_front}        Este campo é obrigatório. Por favor, preencha com um texto
${message_mandatory_email_front}            Este campo é obrigatório. Por favor, insira o e-mail.
${message_mandatory_senha_front}            Sua senha é necessária.
${message_mandatory_empresa_front}          Este campo é obrigatório. Por favor, preencha com um texto
${message_mandatory_cargo_front}            Este campo é obrigatório. Por favor, preencha com um texto
${var_full_name}                            Test complete name
${var_email}                                test@teste.com
${var_senha}                                123abc
${var_empresa}                              testEmpresa
${var_cargo}                                testCargo
${title_after_register_front}               Você recebeu uma moeda! Campanha - Os Agilistas

#Configuration variables
${URL_Login}          https://
${URL_Register}       https://
${Browser}      chrome

#Elements on login page
${input_name}                       id:forminator-field-text-1_640e08031f2ca
${input_password}                   id:forminator-field-password-1_640e08031f2ca
${button_login}                     //*[@id="forminator-module-17221"]/div[5]/div/div/button
${login_error_message}              //*[@id="forminator-module-17221"]/div[1]/label
${message_name_mandatory}           //*[@id="text-1"]/div/span
${message_password_mandatory}       //*[@id="password-1"]/div[1]/span

#Elements on register page
${button_cadastro}                  ou cadastre-se!
${input_full_name}                  id:forminator-field-text-1_640e1b4b05e42
${message_mandatory_full_name}      //*[@id="text-1"]/div/span
${input_email}                      id:forminator-field-email-1_640e1b4b05e42
${message_mandatory_email}          //*[@id="email-1"]/div/span
${input_senha}                      id:forminator-field-password-1_640e1b4b05e42
${message_mandatory_senha}          //*[@id="password-1"]/div/span
${input_empresa}                    id:forminator-field-text-2_640e1b4b05e42
${message_mandatory_empresa}        //*[@id="text-2"]/div/span
${input_cargo}                      id:forminator-field-text-3_640e1b4b05e42
${message_mandatory_cargo}          //*[@id="text-3"]/div/span
${input_checkbox_conditions}        //*[@id="checkbox-1"]/div/label/span[1]
${button_registar}                  //*[@id="forminator-module-17222"]/div[9]/div/div/button

*** Keywords ***
the user access the os agilistas website login
    Open Browser    ${URL_Login}  ${Browser}

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

the user must see the warning message about mandatory name field
    Wait Until Element Contains         ${message_name_mandatory}       ${message_name_mandatory_front}

the user must see the warning message about mandatory password field
    Wait Until Element Contains         ${message_password_mandatory}       ${message_password_mandatory_front}

the user clicks on button cadastre se
    Click Link       ${button_cadastro}

the user must be on the register page
    Title Should Be     ${title_register_page_front}

the user access the os agilistas website register
    Open Browser                ${URL_Register}  ${Browser}
    Maximize Browser Window

the user clicks on field full name
    Click Element      ${input_full_name}

the user press tab key on the field full name
    Press Keys      ${input_full_name}      TAB

the user must see the warning message abou the field full name
    Wait Until Element Contains         ${message_mandatory_full_name}      ${message_mandatory_full_name_front}

the user click on the field email
    Click Element       ${input_email}

the user press tab key on the field email
    Press Keys      ${input_email}      TAB

the user must see the warning message about the email
    Wait Until Element Contains         ${message_mandatory_email}      ${message_mandatory_email_front}

the user click on the field senha
    Click Element       ${input_senha}

the user press tab key on the field senha
    Press Keys      ${input_senha}      TAB

the user must see the warning message about the field senha
    Wait Until Element Contains         ${message_mandatory_senha}      ${message_mandatory_senha_front}

the user click on the field empresa
    Click Element       ${input_empresa}

the user press tab key on the field empresa
    Press Keys      ${input_empresa}    TAB

the user must see the warning message about the field empresa
    Wait Until Element Contains         ${message_mandatory_empresa}      ${message_mandatory_empresa_front}

the user click on the field cargo
    Click Element       ${input_cargo}

the user press tab key on the field cargo
    Press Keys      ${input_cargo}    TAB

the user must see the warning message about the field cargo
    Wait Until Element Contains         ${message_mandatory_cargo}      ${message_mandatory_cargo_front}

the user fill the field full name
    Input Text      ${input_full_name}      ${var_full_name}    

the user fill the field email
    Input Text      ${input_email}      ${var_email}

the user fill the field senha
    Input Text      ${input_senha}      ${var_senha}

the user fill the field empresa
    Input Text      ${input_empresa}        ${var_empresa}

the user fill the field cargo
    Input Text      ${input_cargo}      ${var_cargo}

the user check the conditions check box
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Click Element                 ${input_checkbox_conditions}

the user click on button registar se
    Click Element       ${button_registar}

the user must see the page with congratulations message
    Title Should Be     ${title_after_register_front}


*** Test Cases ***


Scenario 1: Validates if the name field on login is mandatory showing the warning message
    Given the user access the os agilistas website login
    And the user clicks on the field name
    When the user clicks on button login
    Then the user must see the warning message about mandatory name field


Scenario 2: Validates if the password field on login is mandatory showing the warning message
    Given the user access the os agilistas website login
    And the user fill the field name with a wrong name
    When the user clicks on button login
    Then the user must see the warning message about mandatory password field


Scenario 3: Validates if is showed the correctly message when the user tries to login with wrong user and password
    Given the user access the os agilistas website login
    And the user fill the field name with a wrong name
    And fill the field password with a wrong password
    When the user clicks on button login
    Then the user must see the error message

Scenario 4: Validates if the button cadastre se opens the register page
    Given the user access the os agilistas website login
    When the user clicks on button cadastre se
    Then the user must be on the register page

 Scenario 5: Validates if the field Nome complete is mandatory on register
      Given the user access the os agilistas website register
      And the user clicks on field full name
      When the user press tab key on the field full name
      Then the user must see the warning message abou the field full name

Scenario 6: Validates if the field email is mandatory on register
    Given the user access the os agilistas website register
    And the user click on the field email
    When the user press tab key on the field email
    Then the user must see the warning message about the email

Scenario 7: Validates if the field senha is mandatory on register
    Given the user access the os agilistas website register
    And the user click on the field senha
    When the user press tab key on the field senha
    Then the user must see the warning message about the field senha

Scenario 8: Validates if the field empresa is mandatory on register
    Given the user access the os agilistas website register
    And the user click on the field empresa
    When the user press tab key on the field empresa
    Then the user must see the warning message about the field empresa

Scenario 9: Validates if the field cargo is mandatory on register
    Given the user access the os agilistas website register
    And the user click on the field cargo
    When the user press tab key on the field cargo
    Then the user must see the warning message about the field cargo

Scenario 10: Create new register
    Given the user access the os agilistas website register
    And the user fill the field full name
    And the user fill the field email
    And the user fill the field senha
    And the user fill the field empresa
    And the user fill the field cargo
    And the user check the conditions check box
    When the user click on button registar se
    Then the user must see the page with congratulations message


        
