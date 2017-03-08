#!/bin/bash

read -rep $'\n\n#### Ready to install Jenkins & Co to automate your tests?\n\nIf you have questions go to https://webanalyticsfordevelopers.com/2017/03/07/automating-tests/ \n\nFirst apt HTTPS will be installed. Press Enter to continue...\n' -n 1 key

#Install apt HTTPS and update the sources:
sudo apt -y install apt-transport-https
sudo apt update
sudo apt -y dist-upgrade
sudo apt-get -y autoremove

read -rep $'\n\n#### Next Maven, git and JDK8 will be installed. Press Enter to continue...\n' -n 1 key

#Install Maven, git, Java
sudo apt -y install maven git oracle-java8-jdk

read -rep $'\n\n#### Now please choose JDK 8 (should be 2). Press Enter to continue...\n' -n 1 key

#Configure Java to use JDK 8
sudo update-alternatives --config java

read -rep $'\n\n#### Next phantomJS will be downloaded and installed. Press Enter to continue...\n' -n 1 key

#Download and install phantomJS
wget https://github.com/fg2it/phantomjs-on-raspberry/releases/download/v2.1.1-wheezy-jessie-armv6/phantomjs_2.1.1_armhf.deb
sudo dpkg -i phantomjs_2.1.1_armhf.deb
sudo apt-get install -f

read -rep $'\n\n#### Next the apt sources will be updated with the Jenkins repository and Jenkins will be installed. Press Enter to continue...\n' -n 1 key

#Update apt sources to get Jenkins 2
sudo /bin/su -c "echo 'deb https://pkg.jenkins.io/debian binary/' > /etc/apt/sources.list.d/jenkins.list"
wget -q -O - http://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

#Install Jenkins 2
sudo apt update
sudo apt -y install jenkins

#Show initial Adminpassword
lan=$(/sbin/ip -4 -o addr show dev eth0| awk '{split($4,a,"/");print a[1]}')
wlan=$(/sbin/ip -4 -o addr show dev wlan0| awk '{split($4,a,"/");print a[1]}')
echo -e "\n\n#### Open Jenkins in Browser. \n####   With LAN use: "$lan":8080 \n####   With WLAN use: "$wlan":8080\n"
read -rep $'#### After this press Enter to continue...\n' -n 1 key
read -rep $'\n#### If Jenkins ask for Adminpassword, press Enter to continue...\n' -n 1 key
echo "#### The initial Adminpassword is: "
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

read -rep $'\n#### Congratulations, you have successfully installed Jenkins & co to automate your tests!\n\n If you have any further questions go to https://webanalyticsfordevelopers.com/2017/03/07/automating-tests/ \n\nPress Enter to end this script...\n' -n 1 key
