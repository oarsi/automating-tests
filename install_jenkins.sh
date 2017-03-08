#!/bin/sh

# Add and update sources:
sudo apt -y install apt-transport-https
sudo apt update
sudo apt -y dist-upgrade
sudo apt-get -y autoremove

sudo apt -y install maven git oracle-java8-jdk cat

sudo update-alternatives --config java

wget https://github.com/fg2it/phantomjs-on-raspberry/releases/download/v2.1.1-wheezy-jessie-armv6/phantomjs_2.1.1_armhf.deb
sudo dpkg -i phantomjs_2.1.1_armhf.deb
sudo apt-get install -f

sudo /bin/su -c "echo 'deb https://pkg.jenkins.io/debian binary/' > /etc/apt/sources.list.d/jenkins.list"
wget -q -O - http://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

sudo apt update
sudo apt -y install jenkins

sudo cat /var/lib/jenkins/secrets/initialAdminPassword