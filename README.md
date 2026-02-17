# Jobs

Aplicação de publicação de vagas de emprego.

## Tecnologias

- **Backend**: RoR 7
- **Frontend**: Nuxt 3 (Vue.js) + Vuetify

## Instalação e Execução

Aplicação dockerizada. Siga os passos abaixo:

1. **Inicie os containers:**

   ```bash
   docker-compose up -d
   ```

2. **Verifique se os serviços estão rodando:**
   ```bash
   docker-compose ps
   ```

### Services

Deverá executar 4 containers:

| Serviço        | URL                                            | Descrição                      |
| -------------- | ---------------------------------------------- | ------------------------------ |
| **Frontend**   | [http://localhost:3001](http://localhost:3001) | Aplicação Web para usuários    |
| **API**        | [http://localhost:3000](http://localhost:3000) | Backend REST API               |
| **Swagger UI** | [http://localhost:8080](http://localhost:8080) | Documentação interativa da API |
| **Database**   | [http://localhost:5432](http://localhost:5432) | Banco de dados PostgreSQL      |

### Rodar Migrations (se necessário)

Embora o container tente rodar automaticamente, você pode forçar a execução:

```bash
docker-compose exec api bin/rails db:migrate
```

## Estrutura do Projeto

- `api/`: Código fonte do Backend (Ruby on Rails).
- `web/`: Código fonte do Frontend (Nuxt.js).
- `doc/`: Documentação da API (OpenAPI/Swagger).
- `docker-compose.yml`: Definição dos serviços e orquestração.
