# Dbt-devenv

This project was generated with the following command: 
`conveyor project create --name dbt-devenv --conveyor-template-version 1.1.0 --cookiecutter-docker-image datamindedbe/cookiecutter:1.1.0 --template dbt`

Manifest was generated using local instance:
- `docker-compose up`
- `cd dbt/dbt_devenv`
- `dbt seed --target local --profiles-dir ./..`
- `cd ../..`
- `make manifest target=local`

You can directly run dbt commands:
- `export DBT_PROFILES_DIR=/workspace/conveyor-dbt-devenv/dbt`
- `cd dbt/dbt_devenv`
- `dbt run --target local --model staging`

## Prerequisites

- [dbt](https://docs.getdbt.com/dbt-cli/installation/)
- [pyenv](https://github.com/pyenv/pyenv) (recommended)


## Project Structure

```bash
root/
 |-- dags/
 |   |-- project.py
 |-- dbt/
 |   |-- project/
 |   Dockerfile
```

## Concepts

### dbt project structure
Consult the following documentation regarding [best practices for project structure](https://discourse.getdbt.com/t/how-we-structure-our-dbt-projects/355).

### environment variables
It is common practise to pass configuration by [environment variables](https://docs.getdbt.com/reference/dbt-jinja-functions/env_var).
Locally you use a `.env` file to store credentials. 

## Commands
Start a shell in a container with dbt installed and your local files mounted:
- `make env` to create a local `.env` file
- `make shell` to start a new shell
- `exit` to terminate the container shell

For some of the most used Dbt commands a makefile has been added to the project that passes the correct flags to dbt. 
These commands assume they are executed in the shell container.
- `make manifest` executes dbt build and copies the `manifest.json` to your dags folder 
- `make run` executes dbt run
- `make test` executes dbt test
- `make debug` executes dbt debug
- `make docs` executes dbt docs

Consult the [dbt documentation](https://docs.getdbt.com/docs/introduction) for additional commands.