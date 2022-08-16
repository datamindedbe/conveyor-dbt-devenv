FROM public.ecr.aws/dataminded/dbt:v1.1.0

WORKDIR /app
COPY . .
WORKDIR /app/dbt/dbt_devenv

# install dependencies
RUN dbt deps
