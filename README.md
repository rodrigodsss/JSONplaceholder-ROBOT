# Testes de API JSONPlaceholder com Robot Framework

Cadastro completo de testes de API para o [JSONPlaceholder](https://jsonplaceholder.typicode.com),
cobrindo os 6 recursos oficiais (`posts`, `comments`, `albums`, `photos`, `users`, `todos`)
com foco nas requisições de **cadastro (POST)**, e complementado com GET, PUT, PATCH e DELETE.

## Estrutura

```
rf_jsonplaceholder/
├── resources/
│   └── jsonplaceholder.resource   # variáveis e keywords reutilizáveis (1 keyword por endpoint)
├── tests/
│   ├── cadastro_posts.robot       # POST em todos os 6 recursos (foco principal)
│   └── crud_completo.robot        # GET, PUT, PATCH, DELETE
└── README.md
```

## Cobertura de endpoints

| Recurso  | POST (cadastro) | GET | PUT | PATCH | DELETE |
|----------|:---:|:---:|:---:|:---:|:---:|
| posts    | ✅ | ✅ | ✅ | ✅ | ✅ |
| comments | ✅ | ✅ | - | - | - |
| albums   | ✅ | - | - | - | - |
| photos   | ✅ | - | - | - | - |
| users    | ✅ | - | - | - | - |
| todos    | ✅ | - | - | - | - |

> A API é fake: qualquer POST/PUT/PATCH/DELETE responde como se tivesse sido persistido
> (POST sempre retorna `id=101`), mas nada é de fato salvo no servidor.

## Pré-requisitos

```bash
pip install robotframework robotframework-requests
```

## Executando

Rodar tudo:
```bash
robot --outputdir results tests/
```

Rodar apenas os cadastros (POST):
```bash
robot --outputdir results tests/cadastro_posts.robot
```

Rodar por tag:
```bash
robot --outputdir results --include post tests/
```

## Extensão

Para adicionar novos cenários (ex.: validação de contrato/schema, testes negativos com payload
inválido, ou paginação com `_limit`/`_page`), basta criar novas keywords em
`resources/jsonplaceholder.resource` seguindo o mesmo padrão e novos `Test Cases` nos `.robot`.
