*** Settings ***
Documentation       Cadastro completo de keywords para consumo da API JSONPlaceholder
...                 (https://jsonplaceholder.typicode.com) com Robot Framework.
...                 Cobre os 6 recursos oficiais: posts, comments, albums, photos, users, todos.
...                 Suporta os verbos GET, POST, PUT, PATCH e DELETE.
Library             RequestsLibrary
Library             Collections


*** Variables ***
${BASE_URL}             https://jsonplaceholder.typicode.com
${SESSAO}               jsonplaceholder
&{HEADERS_JSON}         Content-Type=application/json; charset=UTF-8


*** Keywords ***
Criar Sessao Jsonplaceholder
    [Documentation]    Cria a sessão HTTP reutilizada por todos os testes.
    Create Session    ${SESSAO}    ${BASE_URL}    verify=True

# ---------------------------------------------------------------------------
# POSTS
# ---------------------------------------------------------------------------
Cadastrar Post
    [Documentation]    POST /posts - cria um novo post (userId, title, body).
    [Arguments]    ${user_id}    ${title}    ${body}
    &{payload}=    Create Dictionary    userId=${user_id}    title=${title}    body=${body}
    ${response}=    POST On Session    ${SESSAO}    /posts    json=${payload}    headers=${HEADERS_JSON}
    RETURN    ${response}

Listar Posts
    [Documentation]    GET /posts - lista todos os posts.
    ${response}=    GET On Session    ${SESSAO}    /posts
    RETURN    ${response}

Obter Post Por Id
    [Documentation]    GET /posts/{id} - obtém um post específico.
    [Arguments]    ${post_id}
    ${response}=    GET On Session    ${SESSAO}    /posts/${post_id}
    RETURN    ${response}

Atualizar Post Completo
    [Documentation]    PUT /posts/{id} - substitui o post inteiro.
    [Arguments]    ${post_id}    ${user_id}    ${title}    ${body}
    &{payload}=    Create Dictionary    id=${post_id}    userId=${user_id}    title=${title}    body=${body}
    ${response}=    PUT On Session    ${SESSAO}    /posts/${post_id}    json=${payload}    headers=${HEADERS_JSON}
    RETURN    ${response}

Atualizar Post Parcial
    [Documentation]    PATCH /posts/{id} - atualiza campos específicos.
    [Arguments]    ${post_id}    &{campos}
    ${response}=    PATCH On Session    ${SESSAO}    /posts/${post_id}    json=${campos}    headers=${HEADERS_JSON}
    RETURN    ${response}

Deletar Post
    [Documentation]    DELETE /posts/{id} - remove o post.
    [Arguments]    ${post_id}
    ${response}=    DELETE On Session    ${SESSAO}    /posts/${post_id}
    RETURN    ${response}

# ---------------------------------------------------------------------------
# COMMENTS
# ---------------------------------------------------------------------------
Cadastrar Comment
    [Documentation]    POST /comments - cria um novo comentário (postId, name, email, body).
    [Arguments]    ${post_id}    ${name}    ${email}    ${body}
    &{payload}=    Create Dictionary    postId=${post_id}    name=${name}    email=${email}    body=${body}
    ${response}=    POST On Session    ${SESSAO}    /comments    json=${payload}    headers=${HEADERS_JSON}
    RETURN    ${response}

Listar Comments Por Post
    [Documentation]    GET /posts/{id}/comments - lista comentários de um post.
    [Arguments]    ${post_id}
    ${response}=    GET On Session    ${SESSAO}    /posts/${post_id}/comments
    RETURN    ${response}

# ---------------------------------------------------------------------------
# ALBUMS
# ---------------------------------------------------------------------------
Cadastrar Album
    [Documentation]    POST /albums - cria um novo álbum (userId, title).
    [Arguments]    ${user_id}    ${title}
    &{payload}=    Create Dictionary    userId=${user_id}    title=${title}
    ${response}=    POST On Session    ${SESSAO}    /albums    json=${payload}    headers=${HEADERS_JSON}
    RETURN    ${response}

# ---------------------------------------------------------------------------
# PHOTOS
# ---------------------------------------------------------------------------
Cadastrar Photo
    [Documentation]    POST /photos - cria uma nova foto (albumId, title, url, thumbnailUrl).
    [Arguments]    ${album_id}    ${title}    ${url}    ${thumbnail_url}
    &{payload}=    Create Dictionary
    ...    albumId=${album_id}
    ...    title=${title}
    ...    url=${url}
    ...    thumbnailUrl=${thumbnail_url}
    ${response}=    POST On Session    ${SESSAO}    /photos    json=${payload}    headers=${HEADERS_JSON}
    RETURN    ${response}

# ---------------------------------------------------------------------------
# USERS
# ---------------------------------------------------------------------------
Cadastrar User
    [Documentation]    POST /users - cria um novo usuário (name, username, email).
    [Arguments]    ${name}    ${username}    ${email}
    &{payload}=    Create Dictionary    name=${name}    username=${username}    email=${email}
    ${response}=    POST On Session    ${SESSAO}    /users    json=${payload}    headers=${HEADERS_JSON}
    RETURN    ${response}

# ---------------------------------------------------------------------------
# TODOS
# ---------------------------------------------------------------------------
Cadastrar Todo
    [Documentation]    POST /todos - cria um novo todo (userId, title, completed).
    [Arguments]    ${user_id}    ${title}    ${completed}=${False}
    &{payload}=    Create Dictionary    userId=${user_id}    title=${title}    completed=${completed}
    ${response}=    POST On Session    ${SESSAO}    /todos    json=${payload}    headers=${HEADERS_JSON}
    RETURN    ${response}
