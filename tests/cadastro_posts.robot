*** Settings ***
Documentation       Cobertura completa de requisições POST (cadastro) da API JSONPlaceholder.
...                 Cada recurso é validado quanto ao status code, ao id retornado
...                 (a API sempre responde com id=101 em criações fake) e ao eco do payload enviado.
Resource            ../resources/jsonplaceholder.resource
Suite Setup         Criar Sessao Jsonplaceholder


*** Test Cases ***
Cadastrar Post Com Sucesso
    [Documentation]    POST /posts
    [Tags]    post    cadastro
    ${response}=    Cadastrar Post    user_id=1    title=Meu Primeiro Post    body=Conteudo de teste via Robot Framework
    Should Be Equal As Integers    ${response.status_code}    201
    Should Be Equal As Strings    ${response.json()}[title]    Meu Primeiro Post
    Should Be Equal As Strings    ${response.json()}[body]    Conteudo de teste via Robot Framework
    Should Be Equal As Integers    ${response.json()}[userId]    1
    Dictionary Should Contain Key    ${response.json()}    id

Cadastrar Comment Com Sucesso
    [Documentation]    POST /comments
    [Tags]    post    cadastro
    ${response}=    Cadastrar Comment
    ...    post_id=1
    ...    name=Comentario de Teste
    ...    email=teste@robotframework.com
    ...    body=Comentario gerado via automacao
    Should Be Equal As Integers    ${response.status_code}    201
    Should Be Equal As Integers    ${response.json()}[postId]    1
    Should Be Equal As Strings    ${response.json()}[email]    teste@robotframework.com
    Dictionary Should Contain Key    ${response.json()}    id

Cadastrar Album Com Sucesso
    [Documentation]    POST /albums
    [Tags]    post    cadastro
    ${response}=    Cadastrar Album    user_id=1    title=Album de Ferias
    Should Be Equal As Integers    ${response.status_code}    201
    Should Be Equal As Strings    ${response.json()}[title]    Album de Ferias
    Should Be Equal As Integers    ${response.json()}[userId]    1
    Dictionary Should Contain Key    ${response.json()}    id

Cadastrar Photo Com Sucesso
    [Documentation]    POST /photos
    [Tags]    post    cadastro
    ${response}=    Cadastrar Photo
    ...    album_id=1
    ...    title=Foto de Teste
    ...    url=https://via.placeholder.com/600
    ...    thumbnail_url=https://via.placeholder.com/150
    Should Be Equal As Integers    ${response.status_code}    201
    Should Be Equal As Strings    ${response.json()}[title]    Foto de Teste
    Should Be Equal As Integers    ${response.json()}[albumId]    1
    Dictionary Should Contain Key    ${response.json()}    id

Cadastrar User Com Sucesso
    [Documentation]    POST /users
    [Tags]    post    cadastro
    ${response}=    Cadastrar User    name=Usuario Teste    username=usuario.teste    email=usuario.teste@robotframework.com
    Should Be Equal As Integers    ${response.status_code}    201
    Should Be Equal As Strings    ${response.json()}[name]    Usuario Teste
    Should Be Equal As Strings    ${response.json()}[username]    usuario.teste
    Dictionary Should Contain Key    ${response.json()}    id

Cadastrar Todo Com Sucesso
    [Documentation]    POST /todos
    [Tags]    post    cadastro
    ${response}=    Cadastrar Todo    user_id=1    title=Finalizar automacao Robot Framework    completed=${False}
    Should Be Equal As Integers    ${response.status_code}    201
    Should Be Equal As Strings    ${response.json()}[title]    Finalizar automacao Robot Framework
    Should Be Equal As Integers    ${response.json()}[userId]    1
    Dictionary Should Contain Key    ${response.json()}    id
