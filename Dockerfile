FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY complete/target/*.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
