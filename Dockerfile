# Use a smaller base image for better performance
FROM openjdk:8-jre-alpine

# Add metadata
LABEL maintainer="manitriniaina2002"
LABEL description="Simple Maven Project"

# Set working directory
WORKDIR /app

# Copy the JAR file from Maven build
COPY target/simple-maven-project-with-tests-1.0-SNAPSHOT.jar app.jar

# Create non-root user for security
RUN addgroup -g 1000 appgroup && \
    adduser -D -s /bin/sh -u 1000 -G appgroup appuser && \
    chown -R appuser:appgroup /app

USER appuser

# Expose port (optional, adjust as needed)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]