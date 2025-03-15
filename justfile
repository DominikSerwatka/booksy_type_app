run:
    mvn spring-boot:run

make-jar:
    mvn clean package

run-jar:
    java -jar target/rest-service-0.0.1-SNAPSHOT.jar

build-docker:
    docker build -t my-spring-app .

run-app-docker:
    docker run -p 8080:8080 --name my-spring-app my-spring-app

stop-app-docker:
    docker stop my-spring-app || true
    docker rm my-spring-app || true

remove-docker-image:
    docker rmi my-spring-app || true

run-compose:
    docker-compose up --build

stop-compose:
    docker-compose down