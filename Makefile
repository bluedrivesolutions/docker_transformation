run_dbt_docs:
	poetry run dbt docs generate
	poetry run dbt docs serve --port 65000

run_all:
	poetry run dbt run

run_stream:
	poetry run dbt run --select tag:streaming

run_batch:
	poetry run dbt run --select tag:batch

run_weekly:
	poetry run dbt run --select tag:weekly