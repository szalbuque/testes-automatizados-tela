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
${DOMINIO}    Domínio de teste 07-02-24 002
${TXT_CONFIRMA_CADASTRO}    Domínio cadastrado com sucesso.

# Page object model (POM)
&{LOGIN_PAGE}
...    UsernameInput=id:formBasicEmail
...    PasswordInput=id:formBasicPassword
...    LoginButton=css:[class='botao-default btn btn-var(--verde-primario)']
...    ErrorMsg=css:[class='Toastify__toast-icon Toastify--animate-icon Toastify__zoom-enter']

&{SISTEMAS_PAGE}
...    BotaoSistema=xpath://div[@title='${SISTEMA}']//div//button

&{BIBLIOTECA_HOME}
...    OpcaoDominio=xpath://html/body/div/div[1]/div/div[2]/div/div/div/div[2]/div/div/div/div[1]/button

&{MENU_DOMINIO}
...    OpcaoCadastrarDominio=xpath://html/body/div/div[1]/div/div[2]/div/div/div/div[2]/div/div[1]/div/div[1]/button

&{TELA_CADASTRAR_DOMINIO}
...    CampoNomeDominio=id:nomeDominio
...    BotaoCadastrar=xpath://html/body/div/div[1]/div/div[2]/div/div/div/div[2]/div/div[2]/div[2]/button

&{MODAL_CONFIRMAR_CADASTRO_DOMINIO}
...    BotaoConfirmar=xpath://html/body/div[3]/div/div/div[3]/div[2]/button

&{MODAL_ALERT}
...    TextoAlert=xpath://html/body/div/div[3]/div/div/div[1]/div[2]

*** Keywords ***

## Ações ##
Realizar login com ${username} e ${password}
    Input Text    ${LOGIN_PAGE.UsernameInput}    ${username}
    Input Text    ${LOGIN_PAGE.PasswordInput}    ${password}
    Click Element    ${LOGIN_PAGE.LoginButton}

Selecionar o sistema com ${button}
    Wait Until Element Is Visible    ${button}
    Click Element    ${button}

Selecionar a opção com ${nome}
    Wait Until Element Is Visible    ${nome}
    Click Element    ${nome}

Digitar no campo com ${campo} e ${conteudo}
    Click Element    ${campo}
    Input Text    ${campo}    ${conteudo}

*** Test Cases ***

Criar um domínio como gestor
    Realizar login com ${USUARIO_GESTOR} e ${SENHA_VALIDA}
    Selecionar o sistema com ${SISTEMAS_PAGE.BotaoSistema}
    Selecionar a opção com ${BIBLIOTECA_HOME.OpcaoDominio}
    Selecionar a opção com ${MENU_DOMINIO.OpcaoCadastrarDominio}
    Digitar no campo com ${TELA_CADASTRAR_DOMINIO.CampoNomeDominio} e ${DOMINIO}
    Click Element    ${TELA_CADASTRAR_DOMINIO.BotaoCadastrar}
    Click Element    ${MODAL_CONFIRMAR_CADASTRO_DOMINIO.BotaoConfirmar}
    IF    '${MODAL_ALERT.TextoAlert}'='${TXT_CONFIRMA_CADASTRO}'
        Log To Console    Cadastro confirmado.
    END