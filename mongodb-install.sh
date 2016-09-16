#!/bin/bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 

echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt-get update
sudo apt-get install -y mongodb-org


sudo apt-get install -y python-software-properties debconf-utils
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer

echo 'Downlaod and install mongo rest server'
wget https://s3-us-west-2.amazonaws.com/gmlvsk/mongoser.tar.gz 

tar xvfz mongoser.tar.gz -C /opt


echo '#!/bin/bash' > /etc/init.d/mongoser.sh
echo '(cd /opt/mongoser && ./bin/mongoser.sh start) ' >> /etc/init.d/mongoser.sh
chmod u+x /etc/init.d/mongoser.sh
/etc/init.d/mongoser.sh

echo 'Downlaod and install tomcat server'
wget http://apache.mirrors.tds.net/tomcat/tomcat-7/v7.0.70/bin/apache-tomcat-7.0.70.tar.gz 

tar xvfz apache-tomcat-7.0.70.tar.gz -C /opt

wget https://www.dropbox.com/sh/u9soo7b8ael8vjg/AAD3X_wO2kSUuXj5FRcqEJRva/ojdbc6-11.2.0.3.0.jar?dl=1 -O /opt/apache-tomcat-7.0.70/lib/ojdbc6-11.2.0.3.0.jar
wget http://repo2.maven.org/maven2/com/h2database/h2/1.4.192/h2-1.4.192.jar -O /opt/apache-tomcat-7.0.70/lib/h2-1.4.192.jar

wget https://www.dropbox.com/sh/u9soo7b8ael8vjg/AACd2fo8qBp_3VwwC1PSC3aMa/ProvAppCLService.war?dl=0 -O /opt/apache-tomcat-7.0.70/webapps/ProvAppCLService.war

echo '#!/bin/bash' > /etc/init.d/tomcat.sh
echo '/opt/apache-tomcat-7.0.70/bin/catalina.sh start' >> /etc/init.d/tomcat.sh
chmod u+x /etc/init.d/tomcat.sh

/etc/init.d/tomcat.sh

echo '#!/bin/bash' > /home/vagrant/redeploy.sh
echo 'rm /opt/apache-tomcat-7.0.70/webapps/ProvAppCLService.war' >> /home/vagrant/redeploy.sh
echo 'sleep 30s' >> /home/vagrant/redeploy.sh
echo 'wget https://www.dropbox.com/sh/u9soo7b8ael8vjg/AACd2fo8qBp_3VwwC1PSC3aMa/ProvAppCLService.war?dl=0 -o /opt/apache-tomcat-7.0.70/webapps/ProvAppCLService.war ' >> /home/vagrant/redeploy.sh

