FROM openjdk:8-jre-slim

# Set working directory
WORKDIR /app

# Copy the JAR file from Maven build
COPY target/simple-maven-project-with-tests-1.0-SNAPSHOT.jar app.jar

# Expose port (optional, adjust as needed)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]