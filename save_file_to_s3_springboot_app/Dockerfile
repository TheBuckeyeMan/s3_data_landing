# Implement essentialy the sstem we want to package wioth 
FROM openjdk:17-jdk
#Specify where the jar file is
ARG JAR_FILE=./save_file_to_s3_springboot_app/target/APIData-0.0.1-SNAPSHOT.jar
#Copy the jar file to the main point of app, call app.jar
COPY target/APIData-0.0.1-SNAPSHOT.jar /app.jar
#Commands to run -> we point to our docker new app called here app.jar(We can change)
ENTRYPOINT ["java","-jar","/app.jar"]