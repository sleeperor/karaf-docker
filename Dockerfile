FROM ubuntu:13.10

RUN apt-get update
RUN apt-get install -y openjdk-7-jre-headless curl bsdtar

#RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/environment

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre

#RUN useradd -m runner

WORKDIR /home/runner

RUN curl --silent --output karaf.tar.gz http://repo2.maven.org/maven2/org/apache/karaf/apache-karaf/3.0.0/apache-karaf-3.0.0.tar.gz
RUN bsdtar -xzf karaf.tar.gz 
RUN mv apache-karaf-3.0.0 apache-karaf
RUN rm karaf.tar.gz
#RUN chown -R runner apache-karaf

WORKDIR /home/runner/apache-karaf/etc

# lets remove the karaf.name by default so we can default it from env vars
RUN sed -i '/karaf.name=root/d' system.properties 

# lets add a user - should ideally come from env vars?
RUN echo >> users.properties 
RUN echo admin=admin,admin >> users.properties 

# lets enable logging to standard out
RUN echo log4j.rootLogger=INFO, stdout, osgi:* >> org.ops4j.pax.logging.cfg 

WORKDIR /home/runner/apache-karaf

# ensure we have a log file to tail 
RUN mkdir -p data/log
RUN echo >> data/log/karaf.log

EXPOSE 8181 8101 1099 2181 9300 61616

CMD echo "starting Apache-Karaf container: " && /home/runner/apache-karaf/bin/karaf server


