*** Settings ***
Library    SeleniumLibrary

Test Setup  Run Keywords
...    Open Browser    url=${URL}    browser=${BROWSER}     AND
...    SeleniumLibrary.Maximize Browser Window

*** Variables ***

${URL}    http://sistemas.t2mlab.com:3008/
${BROWSER}    chrome
${USUARIO_GESTOR}    Alan
${SENHA_VALIDA}    123
${SISTEMA}    Sistema de Biblioteca

# Page object model (POM)
&{LOGIN_PAGE}
...    UsernameInput=id:formBasicEmail
...    PasswordInput=id:formBasicPassword
...    LoginButton=css:[class='botao-default btn btn-var(--verde-primario)']
...    ErrorMsg=css:[class='Toastify__toast-icon Toastify--animate-icon Toastify__zoom-enter']

&{SISTEMAS_PAGE}
...    BotaoSistema=xpath://div[@title='${SISTEMA}']//div//button

*** Keywords ***

## Ações ##
Realizar login com ${username} e ${password}
    Input Text    ${LOGIN_PAGE.UsernameInput}    ${username}
    Input Text    ${LOGIN_PAGE.PasswordInput}    ${password}
    Click Element    ${LOGIN_PAGE.LoginButton}

Selecionar o sistema com ${button}
    Wait Until Element Is Visible    ${button}
    Click Element    ${button}

*** Test Cases ***

Entrar no sistema da biblioteca como gestor
    Realizar login com ${USUARIO_GESTOR} e ${SENHA_VALIDA}
    Selecionar o sistema com ${SISTEMAS_PAGE.BotaoSistema}
    
