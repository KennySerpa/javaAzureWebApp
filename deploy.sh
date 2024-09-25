#!/bin/bash

# Build the project
mvn clean package

# Transfer the WAR file to the server
scp target/javaAzureWebApp.war apache:/tmp/

# SSH into the server and perform deployment steps
ssh apache << EOF
  sudo chown tomcat:tomcat /tmp/javaAzureWebApp.war
  sudo chmod 640 /tmp/javaAzureWebApp.war
  sudo mv /tmp/javaAzureWebApp.war /opt/tomcat/webapps/
  sudo systemctl restart tomcat
EOF

echo "Deployment completed successfully!"
