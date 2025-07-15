
[使用 docker-compose](https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html)

```bash
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/3.0.2/docker-compose.yaml'

mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env

docker compose version # >= 2.14.0

docker compose run airflow-cli airflow config list > config/airflow.cfg

# db migration and user creation
docker compose up airflow-init

# run with [flower](https://flower.readthedocs.io/en/latest/)
docker compose up flower
# user:pass = airflow:airflow

docker compose down --volumes --remove-orphans
```
