run:
    mvn spring-boot:run

make-jar:
    mvn clean install -DskipTests

run-jar:
    java -jar target/rest-service-0.0.1-SNAPSHOT.jar

build-docker:
    docker build -t my-spring-app .

run-app-docker:
    docker run -p 8080:8080 --network=rest-service_rest-service --name my-spring-app my-spring-app

stop-app-docker:
    docker stop my-spring-app || true
    docker rm my-spring-app || true

remove-docker-image:
    docker rmi my-spring-app || true

run-compose:
    docker-compose up

stop-compose:
    docker-compose down

migrate:
    mvn spring-boot:run -Dconsole=true -Dspring-boot.run.profiles=console-application

new-run:
    just make-jar
    just build-docker
    just run-app-docker

check-database:
    docker exec -it postgresql bash
    psql -U myuser -d mydatabase


stop-docker:
    docker stop my-spring-app || true
    docker rm my-spring-app || true
    docker rmi my-spring-app || true
