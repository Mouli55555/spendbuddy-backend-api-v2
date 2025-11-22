# Stage 1: Build the JAR using Maven + JDK 21
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

COPY . .

# Fix mvnw permissions
RUN chmod +x mvnw

RUN ./mvnw clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:21-jdk

WORKDIR /app

# Copy built jar from stage 1
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
