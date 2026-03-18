FROM gradle:7.6-jdk17 AS build

WORKDIR /app
COPY . .

RUN gradle war

FROM tomcat:9.0

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY --from=build /app/build/libs/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]