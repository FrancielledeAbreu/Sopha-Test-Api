
## Francielle Sopha Test

Descrição do teste: [https://github.com/BrunoSDias/Sopha-Test-Api]

🚀 Começando
Estas instruções fornecerão uma cópia do projeto em execução na sua máquina local para fins de desenvolvimento e teste.

Pré-requisitos
O que você precisa para instalar o software:

[Docker](https://www.docker.com/)
[Docker Compose](https://docs.docker.com/compose/)

#### Instalação
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

#### 🧪 Testes
Para rodar os testes, execute:
```
docker-compose run web rspec
```
#### 📌 API Endpoints
#### base_url
Local:http://localhost:3000
Produção: http://ec2-3-137-178-138.us-east-2.compute.amazonaws.com

*Obs: utilizar http, pois não foi adquirido um certificado SSL.*

##### Autenticação
###### Registro
Endpoint: POST base_url/register

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
###### Login

Endpoint: POST base_url/login
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
###### Usuários
###### Obter detalhes do usuário autenticado
Endpoint: GET base_url/user
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

###### Obter as lojas do usuário autenticado
Endpoint: GET base_url/user/stores
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
##### Lojas
###### Obter todas as lojas do usuário autenticado
Endpoint: GET base_url/stores
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
###### Obter detalhes de uma loja específica
Endpoint: GET base_url/stores/:id
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
###### Criar uma nova loja
Endpoint: POST base_url/stores
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
###### Atualizar uma loja
Endpoint: PUT base_url/stores/:id
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
###### Deletar uma loja
Endpoint: DELETE base_url/stores/:id
Headers: Authorization: Bearer [token]
```
Response:
json
{
  "message": "Store deleted successfully"
}
```

### Deploy   ![Deploy](https://img.shields.io/badge/Deploy-success-brightgreen)

O Deploy foi realizado em uma Instância EC2, segue o passo a passo de como foi realizado:

**1. Criei uma instância EC2:**

Acessei o AWS Management Console e fui para o serviço EC2.
Cliquei em "Launch Instance" e selecionei a AMI desejada
Escolhi um tipo de instância como t2.medium
Configurei o Security Group e Volumes.

###### Comandos para acessar SSh instância EC2:

**2. Criei o pem_file**
```
chmod 0400 PEM_FILE.pem
```

No console da instância
```
ssh -i PEM_FILE.pem ec2-user@PUBLIC_IP
```

**3. Instalei Aas dependêcias**
Instalei docker, docker-compose e ngnix

**4. Transferi os arquivos**
```
scp -i ~/PEM_FILE.pem -r file ec2-user@PUBLIC_IP:file
```

Além de criar banco e rodar a migrations dentro do volume da instância

**4. Configurei Ngnix**
Foi necessário adicionar as configurações do Ngnix:
```
server {
    listen 80;
    server_name PUBLIC_IP;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```
```
sudo systemctl restart nginx
```

