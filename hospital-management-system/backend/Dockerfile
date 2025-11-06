 # ---------- Build stage ----------
 FROM maven:3.9-eclipse-temurin-17 AS build
 WORKDIR /app
 
 # Cache dependencies
 COPY pom.xml .
 RUN --mount=type=cache,target=/root/.m2 mvn -q -e -DskipTests dependency:go-offline
 
 # Build
 COPY src ./src
 RUN --mount=type=cache,target=/root/.m2 mvn -q -DskipTests package
 
 # ---------- Runtime stage ----------
 FROM eclipse-temurin:17-jre
 WORKDIR /app
 
 # Copy built jar
 COPY --from=build /app/target/*.jar /app/app.jar
 
 ENV JAVA_OPTS=""
 EXPOSE 8080
 
 ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/app.jar"]

