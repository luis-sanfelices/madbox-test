run-spark:
	docker compose -f ./ops/docker/docker-compose.yml up -d
deploy-app:
	docker cp -L ./src spark-master:/opt/bitnami/spark
stop:
	docker compose -f ./ops/docker/docker-compose.yml down 
run-app:
	docker exec spark-master spark-submit --master spark://172.19.0.2:7077 main.py
logs:
	docker logs spark-master