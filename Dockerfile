# Use an official Java runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the target directory into the container
COPY target/intro_KevinDalling_301247589-0.0.1-SNAPSHOT.jar app.jar

# Expose the port on which the application runs
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
