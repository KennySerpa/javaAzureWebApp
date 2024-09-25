#!/bin/bash

# Build the project
mvn clean package

# Transfer the WAR file to the server
scp target/javaAzureWebApp.war apache:/tmp/

# SSH into the server and perform deployment steps
ssh apache << EOF
  sudo -n chown tomcat:tomcat /tmp/javaAzureWebApp.war
  sudo -n chmod 640 /tmp/javaAzureWebApp.war
  sudo -n mv /tmp/javaAzureWebApp.war /opt/tomcat/webapps/
  sudo -n systemctl restart tomcat
EOF

echo "Deployment completed successfully!"

kserpa ALL=(ALL) NOPASSWD: /bin/chown tomcat:tomcat /tmp/javaAzureWebApp.war, /bin/chmod 640 /tmp/javaAzureWebApp.war, /bin/mv /tmp/javaAzureWebApp.war /opt/tomcat/webapps/, /bin/systemctl restart tomcat
