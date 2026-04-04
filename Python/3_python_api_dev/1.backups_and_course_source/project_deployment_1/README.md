# FastAPI + PostgreSQL deployment ready

- FastAPI / Uvicorn functional
- PostgreSQL database
- Fully functional - create user, login, new post, retrieve post, vote
- Persistent database (stored in a Docker Volume)
- Docker containerized API and Postgres services
- !!! Project folder bind-mount in API container + uvicorn --reload for convenient source code update
- !!! Env variables hard-coded in doocker-compose for convenience
- Custom Dockerfile for API service image
- Docker Compose used to bring services up
- Once containers are up, perform database migrations Alembic:
`docker compose exec api alembic upgrade head`

