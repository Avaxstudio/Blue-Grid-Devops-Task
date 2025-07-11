FROM eclipse-temurin:17 AS builder
WORKDIR /app

COPY complete/.mvn/ .mvn/
COPY complete/mvnw .
COPY complete/pom.xml .
COPY complete/src/ ./src/

RUN chmod +x mvnw && ./mvnw -B clean package -DskipTests=true

FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
