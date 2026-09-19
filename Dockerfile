# Stage 1: Build the VoxelBridge JAR file using Maven and Java 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the built JAR file using a lightweight Java 21 runtime
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/voxelbridge-*-SNAPSHOT.jar app.jar

# Expose the internal port for the proxy traffic
EXPOSE 10000

# Run VoxelBridge automatically when Render starts the container
ENTRYPOINT ["java", "-jar", "app.jar"]
