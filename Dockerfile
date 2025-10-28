# ===== Stage 1: Build =====
FROM maven:3.9.2-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar arquivos do projeto
COPY pom.xml .

# Build do projeto (gera o JAR)
RUN mvn clean package -DskipTests

# ===== Stage 2: Runtime =====
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Copiar o JAR do stage anterior
COPY --from=build /app/target/*.jar app.jar

# Porta exposta pelo Spring Boot
EXPOSE 8080

# Rodar o JAR
CMD ["java", "-jar", "app.jar"]
