
## Francielle Sophia Test

Descrição do teste: [https://github.com/BrunoSDias/Sopha-Test-Api]

🚀 Começando
Estas instruções fornecerão uma cópia do projeto em execução na sua máquina local para fins de desenvolvimento e teste.

Pré-requisitos
O que você precisa para instalar o software:

[Docker](https://www.docker.com/)
[Docker Compose](https://docs.docker.com/compose/)

####Instalação
Clone o repositório:
```
git clone git@github.com:FrancielledeAbreu/Sopha-Test-Api.git
```
Navegue até a pasta do projeto:
```
cd Sopha-Test-Api
```
Construa e inicie os serviços usando Docker Compose:
```
docker-compose up --build
```

####🧪 Testes
Para rodar os testes, execute:
```
docker-compose run web rspec
```
####📌 API Endpoints
#####Autenticação
######Registro
Endpoint: POST /register

```
Body:
json
{
  "name": "Nome",
  "email": "email@example.com",
  "password": "senha123"
}
```
Response:
Success Response:
Code: 200 OK
```
json
{
  "token": "token",
  "user": {
    "id": 1,
    "email": "email@example.com",
    "name": "Nome"
  }
}
```
######Login
Endpoint: POST /login
```
Body:
json
{
  "email": "email@example.com",
  "password": "senha123"
}
```
Response:
Success Response:
Code: 200 OK
```
json
{
  "token": "token"
}
```
######Usuários
######Obter detalhes do usuário autenticado
Endpoint: GET /user
Headers: Authorization: Bearer [token]
Success Response:
Code: 200 OK
```
Content:
json
{
  "id": 1,
  "email": "email@example.com",
  "name": "Nome"
}
```
Error Responses:
Code: 401 UNAUTHORIZED
```
Content: { "error": "Not authorized" }
```

######Obter as lojas do usuário autenticado
Endpoint: GET /user/stores
Headers: Authorization: Bearer [token]
Success Response:
Code: 200 OK
```
[
	{
		"id": 3,
		"name": "Teste ",
		"user_id": 4,
		"created_at": "2023-09-23T13:10:47.677Z",
		"updated_at": "2023-09-23T13:10:47.677Z"
	},
	{
		"id": 4,
		"name": "Teste ",
		"user_id": 4,
		"created_at": "2023-09-24T00:14:36.888Z",
		"updated_at": "2023-09-24T00:14:36.888Z"
	}
]
```
Error Responses:
Code: 401 UNAUTHORIZED
```
Content: { "error": "Not authorized" }
```
#####Lojas
######Obter todas as lojas do usuário autenticado
Endpoint: GET /stores
Headers: Authorization: Bearer [token]

Response:
json
```
[
	{
		"id": 5,
		"name": "Teste ",
		"user_id": 2,
		"created_at": "2023-09-24T00:37:49.307Z",
		"updated_at": "2023-09-24T00:37:49.307Z"
	},
  ...
]
```
######Obter detalhes de uma loja específica
Endpoint: GET /stores/:id
Headers: Authorization: Bearer [token]
Response:
json
```
{
	"id": 5,
	"name": "Teste ",
	"user_id": 2,
	"created_at": "2023-09-24T00:37:49.307Z",
	"updated_at": "2023-09-24T00:37:49.307Z"
}
```
######Criar uma nova loja
Endpoint: POST /stores
Headers: Authorization: Bearer [token]
Body:
json
```
{
  "name": "Nome da loja"
}
```
Response:
json
```
{
  "id": 1,
  "name": "Nome da loja"
}
```
######Atualizar uma loja
Endpoint: PUT /stores/:id
Headers: Authorization: Bearer [token]
Body:
json
```
{
  "name": "Nome atualizado da loja"
}
```
Response:
json
```
{
  "id": 1,
  "name": "Nome atualizado da loja"
}
```
######Deletar uma loja
Endpoint: DELETE /stores/:id
Headers: Authorization: Bearer [token]
```
Response:
json
{
  "message": "Store deleted successfully"
}



