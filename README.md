# Jobs

Aplicação de publicação de vagas de emprego.

## Tecnologias

- **Backend**: RoR 7
- **Frontend**: Nuxt 3 (Vue.js) + Vuetify

## Instalação e Execução

Aplicação dockerizada. Siga os passos abaixo:

**Configuração Inicial:**

Antes de iniciar, você precisa configurar as variáveis de ambiente.

```bash
cp .env.example .env
```

Isso criará o arquivo `.env` na **raiz do repositório** com as configurações padrão. **Não é necessário alterar nada** para rodar localmente.

**Inicie os containers:**

```bash
docker-compose --profile app up
```

Isso irá subir os containers.

**Inicie os containers com a documentação:**

```bash
docker-compose --profile app --profile docs up
```

Iniciando assim o banco já será instalado quando não tiver.

### Services

Deverá executar 4 containers:

| Serviço        | URL                                            | Descrição                      |
| -------------- | ---------------------------------------------- | ------------------------------ |
| **Frontend**   | [http://localhost:3001](http://localhost:3001) | Aplicação Web para usuários    |
| **API**        | [http://localhost:3000](http://localhost:3000) | Backend REST API               |
| **Swagger UI** | [http://localhost:8080](http://localhost:8080) | Documentação interativa da API |
| **Database**   | [http://localhost:5432](http://localhost:5432) | Banco de dados PostgreSQL      |

## Estrutura do Projeto

- `api/`: Código fonte do Backend (Ruby on Rails).
- `web/`: Código fonte do Frontend (Nuxt.js).
- `doc/`: Documentação da API (OpenAPI/Swagger).
- `docker-compose.yml`: Definição dos serviços e orquestração.

## Acessando área de administração

1. Fazer login na aplicação com cadastro feito pelo seed
   - Email: admin@example.com.br
   - Senha: `password`
2. Se já não for redirecionado clique no botão `Admin`.

## Swagger

Para utilizar o Swagger neste projeto, siga os passos abaixo:

1. **Inicie o container de documentação (junto com a aplicação):**

   ```bash
   docker-compose --profile docs up
   ```

   _(Ou `--profile app --profile docs` se quiser garantir que sobe tudo)_

2. **Acesse no navegador:**

   [http://localhost:8080](http://localhost:8080)

### Manutenção da Documentação

A documentação **não é gerada automaticamente**. Ela é definida manualmente no arquivo:

- `doc/openapi.yaml`

Para alterar ou adicionar novos endpoints, edite este arquivo e recarregue a página do Swagger UI.

## O que gostaria de fazer e não deu tempo

- Mais atenção para testes com Rspec
- Refactoring de backend e frontend principalmente
- Área de candidatos
- Servidor MCP para prover dados de candidatos para ferramentas de IA
