#!/bin/bash
file="/etc/cron.d/automation"
echo "* * 1 * * root /root/Automation_Project/automation.sh" > $file

chmod +x /home/ubuntu/Automation_Project/automation_1.sh
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2

sudo systemctl enable apache2
sudo apt install awscli -y
timestamp=$(date '+%d%m%Y-%H%M%S')
tar -cvf /tmp/dipesh-httpd-logs-${timestamp}.tar /var/log/apache2/access.log /var/log/apache2/error.log
aws s3 \
cp /tmp/dipesh-httpd-logs-${timestamp}.tar \
s3://upgrad-dipesh/dipesh-httpd-logs-${timestamp}.tar
aws s3 ls upgrad-dipesh > /var/www/html/inventory.html

