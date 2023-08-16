docker_build:
	docker build -t test/spark-operator:latest .

docker_app:
	docker build -f Dockerfile-app -t test/spark-scala-k8-app:latest .

change_tag:
	yq -i '.spec.image = "hasnii/spark:${{steps.get-short-sha-id.outputs.sha}}"' config/spark.yaml