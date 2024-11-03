FROM openjdk:17-jdk-alpine

WORKDIR /my-java-app

COPY target/aysegul-proje-0.0.1-SNAPSHOT.jar myapp.jar

ENTRYPOINT ["java", "-jar", "myapp.jar"]

