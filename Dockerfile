FROM ubuntu:latest
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install openjdk-8-jdk wget
RUN mkdir /usr/local/tomcat
RUN wget http://mirrors.wuchna.com/apachemirror/tomcat/tomcat-9/v9.0.12/bin/apache-tomcat-9.0.12.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-9.0.12/* /usr/local/tomcat/
ADD ./target/*.war /usr/local/tomcat/webapps/ 
EXPOSE 8082
CMD /usr/local/tomcat/bin/catalina.sh run
