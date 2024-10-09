run_dbt_docs:
	poetry run dbt docs generate
	poetry run dbt docs serve --port 65000