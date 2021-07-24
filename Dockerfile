
FROM ubuntu:latest

RUN apt-get upgrade apt
RUN apt update -y\
    && apt -y install ssh openssh-server


RUN apt -y install  openjdk-8-jdk \
    && update-java-alternatives -s java-1.8.0-openjdk-amd64

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/





#Copy hadoop
COPY spark-3.0.2-bin-hadoop2.7.tgz /usr/local/
WORKDIR /usr/local/
RUN tar -xf spark-3.0.2-bin-hadoop2.7.tgz \
    && rm spark-3.0.2-bin-hadoop2.7.tgz \
    && ln -s ./spark-3.0.2-bin-hadoop2.7 spark

ENV PATH="/usr/local/spark/bin:${PATH}"

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 0600 ~/.ssh/authorized_keys

#Bypass interactive prompt
RUN echo "Host *"  >>/root/.ssh/config
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config

WORKDIR /bin/

ADD bootstrap_master.sh /bin/
ADD bootstrap_worker.sh /bin/
RUN chmod +x bootstrap_master.sh
RUN chmod +x bootstrap_worker.sh


EXPOSE 22 7077 8080

#Debug

#RUN apt-get install -y xinetd telnetd
#RUN apt-get install -y net-tools iputils-ping
