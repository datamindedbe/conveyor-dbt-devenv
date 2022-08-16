from airflow import DAG
from conveyor.factories import ConveyorDbtTaskFactory
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
    "dbt-devenv", default_args=default_args, schedule_interval="@daily", max_active_runs=1
)

factory = ConveyorDbtTaskFactory(
    task_aws_role="dbt-devenv-{{ macros.conveyor.env() }}",
)
factory.add_tasks_to_dag(dag=dag)
