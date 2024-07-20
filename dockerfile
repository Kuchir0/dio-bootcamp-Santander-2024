# Use a imagem oficial do Maven para construir o projeto
FROM maven:3.8.5-openjdk-17-slim AS build

# Setar o diretório de trabalho no contêiner
WORKDIR /app

# Copiar o arquivo pom.xml e o código-fonte para o contêiner
COPY pom.xml .
COPY src ./src

# Rodar o Maven para construir o projeto
RUN mvn clean package -DskipTests

# Usar a imagem oficial do OpenJDK para o runtime
FROM openjdk:17-jdk-slim

# Setar o diretório de trabalho no contêiner
WORKDIR /app

# Copiar o JAR do estágio de build para o contêiner do runtime
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expôr a porta que o aplicativo vai rodar
EXPOSE 8080

# Comando para rodar o aplicativo
ENTRYPOINT ["java", "-jar", "app.jar"]
