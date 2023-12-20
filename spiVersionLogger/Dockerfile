FROM openjdk:17-jdk-slim
COPY target/spiVersionLogger-0.0.1-SNAPSHOT.jar dummy-server-1.0.0.jar
ENTRYPOINT ["java", "-jar", "/dummy-server-1.0.0.jar"]

#FROM openjdk:11-jdk
#USER 0
#RUN mkdir -p runner
#COPY ./* runner
#RUN cd runner

