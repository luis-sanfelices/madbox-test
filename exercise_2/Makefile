run-spark:
	docker compose -f docker-compose.yaml up -d
deploy-app:
	docker cp -L ./src spark-master:/opt/bitnami/spark
stop:
	docker compose -f docker-compose.yaml down 
run-app:
	docker exec spark-master spark-submit --master spark://172.19.0.2:7077 src/main.py
logs:
	docker logs spark-master