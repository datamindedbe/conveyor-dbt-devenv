from airflow import DAG
from conveyor.secrets import AWSSecretsManagerValue
from conveyor.operators import ConveyorContainerOperatorV2
from datetime import datetime, timedelta


default_args = {
    "owner": "Conveyor",
    "depends_on_past": False,
    "start_date": datetime(year=2022, month=8, day=15),
    "email": [],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 0,
    "retry_delay": timedelta(minutes=5),
}


dag = DAG(
    "dbt-devenv-seed", default_args=default_args, schedule_interval="@once", max_active_runs=1
)

ConveyorContainerOperatorV2(
    dag=dag,
    task_id="seed",
    arguments=["seed", "--target", "{{ macros.conveyor.env() }}", "--profiles-dir", "./..",],
    env_vars={"DBT_PASSWORD": AWSSecretsManagerValue(name="conveyor-dbt-devenv-rds"), },
    aws_role="dbt-devenv-{{ macros.conveyor.env() }}",
)
