# ===== Stage 1: Build =====
FROM maven:3.9.2-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar pom.xml e baixar dependências primeiro (cache mais eficiente)
COPY pom.xml .
RUN mvn dependency:go-offline

# Agora copiar o código-fonte
COPY src ./src

# Build do projeto (gera o JAR)
RUN mvn clean package -DskipTests

# ===== Stage 2: Runtime =====
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Copiar o JAR do estágio anterior
COPY --from=build /app/target/*.jar app.jar

# Porta padrão do Spring Boot
EXPOSE 8080

# Executar o JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
