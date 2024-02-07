# Sistema Competências
# FRONTEND PORT: 3006
# BACKEND PORT: 8015
# SWAGGER: http://sistemas.t2mlab.com:8015/swagger-ui/index.html
# URL: http://sistemas.t2mlab.com:3006

*** Settings ***
Library    SeleniumLibrary

Test Setup  Run Keywords
...    Open Browser    url=${URL}    browser=${BROWSER}     AND
...    SeleniumLibrary.Maximize Browser Window

*** Variables ***

${URL}    http://sistemas.t2mlab.com:3006/
${BROWSER}    chrome
${USUARIO_GESTOR}    Alan
${SENHA_VALIDA}    123
${SISTEMA}    Sistema de Competência
${SERVICO}    Qualidade

# Page object model (POM)
&{LOGIN_PAGE}
...    UsernameInput=id:formBasicEmail
...    PasswordInput=id:formBasicPassword
...    LoginButton=css:[class='botao-default btn btn-var(--verde-primario)']
...    ErrorMsg=css:[class='Toastify__toast-icon Toastify--animate-icon Toastify__zoom-enter']

&{SISTEMAS_PAGE}
...    BotaoSistema=xpath://div[@title='${SISTEMA}']//div//button

&{HOME_COMPETENCIAS}
...    OpcaoEmpresa=xpath://div[@title='Empresa']//a

&{HOME_EMPRESA}
...    OpcaoBuscarEmpresa=xpath://div[@title='Buscar Empresa']//a

&{TELA_BUSCAR_EMPRESA}
...    CampoBusca=css:[class='form-control']

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

Visualizar as empresas filtrando por serviços
    Realizar login com ${USUARIO_GESTOR} e ${SENHA_VALIDA}
    Selecionar o sistema com ${SISTEMAS_PAGE.BotaoSistema}
    Selecionar a opção com ${HOME_COMPETENCIAS.OpcaoEmpresa}
    Selecionar a opção com ${HOME_EMPRESA.OpcaoBuscarEmpresa}
    Digitar no campo com ${TELA_BUSCAR_EMPRESA.CampoBusca} e ${SERVICO}

## Neste ponto deveria haver uma forma de verificar se estão sendo exibidos somente as empresas com o serviço digitado.



