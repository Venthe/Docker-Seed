FROM "docker.io/library/gradle:7.1.1-jdk16" AS builder
ADD . ./
RUN --mount=type=cache,target=/home/gradle/.gradle gradle assemble \
      --console=plain \
      --info \
      --stacktrace \
      --no-daemon
RUN java -Djarmode=layertools -jar /home/gradle/build/libs/server.jar extract

FROM "docker.io/library/adoptopenjdk:16.0.1_9-jre-openj9-0.26.0"
WORKDIR application
EXPOSE 8080
COPY --from=builder /home/gradle/dependencies/ ./
COPY --from=builder /home/gradle/spring-boot-loader/ ./
COPY --from=builder /home/gradle/snapshot-dependencies/ ./
COPY --from=builder /home/gradle/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
