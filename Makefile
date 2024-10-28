run_dbt_docs:
	poetry run dbt docs generate
	poetry run dbt docs serve --port 65000

run_all:
	poetry run dbt run

run_stream:
	poetry run dbt run --select tag:stream

run_batch:
	poetry run dbt run --select tag:batch

run_weekly:
	poetry run dbt run --select tag:weekly

# run_docker_stream:
# 	sudo docker exec -it dbt bash -c "poetry dbt run --select tag:weekly"