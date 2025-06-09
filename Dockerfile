# FROM openjdk:17-alpine
        
# ENV APP_HOME=/usr/src/app

# WORKDIR $APP_HOME

# COPY . .

# RUN mvn clean package

# COPY target/*.jar $APP_HOME/app.jar


# CMD ["java", "-jar", "app.jar"]

# EXPOSE 8080

# ----- Stage 1: Build -----
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build

WORKDIR /app

# Copy all project files to the container
COPY . .

# Build the app
RUN mvn clean package -DskipTests

# ----- Stage 2: Run -----
FROM openjdk:17-alpine

ENV APP_HOME=/usr/src/app
WORKDIR $APP_HOME

# Copy only the JAR from the previous stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
