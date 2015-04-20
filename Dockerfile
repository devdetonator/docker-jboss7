FROM otechlabs/java7:76.13

RUN mkdir -p /usr/local/share && \
    wget -qO- http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz | gunzip | tar x -C /usr/local/share/ && \
    mv /usr/local/share/jboss* /usr/local/share/jboss

RUN mkdir -p /usr/local/share/jboss/modules/com/mysql/main
ADD mariadb-java-client-1.1.8.jar /usr/local/share/jboss/modules/com/mysql/main/mariadb-java-client-1.1.8.jar
ADD module_1.1.8.xml /usr/local/share/jboss/modules/com/mysql/main/module.xml

RUN /usr/local/share/jboss/bin/add-user.sh --silent=true admin $HOSTNAME && \
    echo $HOSTNAME > /usr/local/share/jboss/admin.pass

EXPOSE 9999 9990 8080

CMD ["/usr/local/share/jboss/bin/standalone.sh"]
