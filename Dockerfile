# Use the official OpenJDK Alpine image for Java 17
FROM openjdk:17

# Expose the port the application runs on
EXPOSE 8080

# Create a non-privileged user and group
# Also install curl for the healthcheck to work
RUN apk --no-cache add curl && \
    addgroup -S spring && adduser -S spring -G spring

# Switch to the non-privileged user
USER spring:spring

# Set the working directory
WORKDIR /usr/src/app

# Copy the JAR file to the container using a wildcard
COPY target/*.jar app.jar

# Healthcheck to ensure the application is running
HEALTHCHECK --interval=45s --timeout=15s CMD curl -f http://localhost:8080/actuator/health || exit 1

# Set environment variables (optional)
ENV JAVA_OPTS=""

# Command to run the JAR file
ENTRYPOINT ["java", "-jar", "/usr/src/app/app.jar"]