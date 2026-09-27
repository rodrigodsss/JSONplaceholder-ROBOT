*** Settings ***
Documentation       Cobertura dos demais verbos HTTP (GET, PUT, PATCH, DELETE) da API JSONPlaceholder,
...                 complementando o cadastro (POST) coberto em cadastro_posts.robot.
Resource            ../resources/jsonplaceholder.resource
Suite Setup         Criar Sessao Jsonplaceholder


*** Test Cases ***
Listar Todos Os Posts
    [Documentation]    GET /posts
    [Tags]    get
    ${response}=    Listar Posts
    Should Be Equal As Integers    ${response.status_code}    200
    Length Should Be    ${response.json()}    100

Obter Post Especifico
    [Documentation]    GET /posts/{id}
    [Tags]    get
    ${response}=    Obter Post Por Id    post_id=1
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Integers    ${response.json()}[id]    1

Listar Comentarios De Um Post
    [Documentation]    GET /posts/{id}/comments
    [Tags]    get
    ${response}=    Listar Comments Por Post    post_id=1
    Should Be Equal As Integers    ${response.status_code}    200
    Should Not Be Empty    ${response.json()}

Atualizar Post Completo Com Sucesso
    [Documentation]    PUT /posts/{id}
    [Tags]    put
    ${response}=    Atualizar Post Completo
    ...    post_id=1
    ...    user_id=1
    ...    title=Titulo Atualizado
    ...    body=Corpo atualizado via PUT
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()}[title]    Titulo Atualizado

Atualizar Post Parcialmente Com Sucesso
    [Documentation]    PATCH /posts/{id}
    [Tags]    patch
    ${response}=    Atualizar Post Parcial    post_id=1    title=Somente o Titulo Mudou
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()}[title]    Somente o Titulo Mudou

Deletar Post Com Sucesso
    [Documentation]    DELETE /posts/{id}
    [Tags]    delete
    ${response}=    Deletar Post    post_id=1
    Should Be Equal As Integers    ${response.status_code}    200
