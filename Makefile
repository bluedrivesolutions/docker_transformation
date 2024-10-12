run_dbt_docs:
	poetry run dbt docs generate
	poetry run dbt docs serve --port 65000

run_all:
	poetry run dbt run

run_stream_tag:
	poetry run dbt run --select tag:streaming

run_batch_tag:
	poetry run dbt run --select tag:batch

run_weekly_tag:
	poetry run dbt run --select tag:weekly