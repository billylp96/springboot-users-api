
##stage 1
FROM amazoncorretto:21-alpine-jdk AS builder
WORKDIR /app
COPY .mvn ./.mvn
COPY mvnw .
COPY pom.xml .
COPY src ./src
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

#stage 2
FROM amazoncorretto:21-alpine-jdk
WORKDIR /app
COPY --from=builder /app/target/usuarios-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT [ "java","-jar","app.jar" ]
