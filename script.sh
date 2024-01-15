#!/bin/bash

sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat

sudo apt update -y

sudo apt upgrade -y

sudo apt install openjdk-17-jdk -y

sudo wget -P /tmp https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.18/bin/apache-tomcat-10.1.18.tar.gz

sudo tar xzvf /tmp/apache-tomcat-10.1.18.tar.gz -C /opt/tomcat --strip-components=1

sudo chown -R tomcat:tomcat /opt/tomcat/

sudo chmod -R u+x /opt/tomcat/bin

sudo sed -i '/<\/tomcat-users>/i\    <role rolename="manager-gui" />\n    <user username="ubuntu" password="1234" roles="manager-gui" />\n    <role rolename="admin-gui" />\n    <user username="admin" password="1234" roles="manager-gui,admin-gui" />' /opt/tomcat/conf/tomcat-users.xml

echo '<?xml version="1.0" encoding="UTF-8"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<Context antiResourceLocking="false" privileged="true" >
  <CookieProcessor className="org.apache.tomcat.util.http.Rfc6265CookieProcessor"
                   sameSiteCookies="strict" />
  <!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
 <Manager sessionAttributeValueClassNameFilter="java\.lang\.(?:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|java\.util\.(?:Linked)?HashMap"/>-->
</Context>' | sudo tee /opt/tomcat/webapps/manager/META-INF/context.xml > /dev/null

echo '<?xml version="1.0" encoding="UTF-8"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<Context antiResourceLocking="false" privileged="true" >
  <CookieProcessor className="org.apache.tomcat.util.http.Rfc6265CookieProcessor"
                   sameSiteCookies="strict" />
  <!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
  <Manager sessionAttributeValueClassNameFilter="java\.lang\.(?:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|java\.util\.(?:Linked)?HashMap"/>
</Context>' | sudo tee /opt/tomcat/webapps/host-manager/META-INF/context.xml > /dev/null

echo -e "[Unit]\nDescription=Tomcat\nAfter=network.target\n\n[Service]\nType=forking\nUser=tomcat\nGroup=tomcat\nEnvironment=\"JAVA_HOME=/usr/lib/jvm/java-1.17.0-openjdk-amd64\"\nEnvironment=\"JAVA_OPTS=-Djava.security.egd=file:///dev/urandom\"\nEnvironment=\"CATALINA_BASE=/opt/tomcat\"\nEnvironment=\"CATALINA_HOME=/opt/tomcat\"\nEnvironment=\"CATALINA_PID=/opt/tomcat/temp/tomcat.pid\"\nEnvironment=\"CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC\"\n\nExecStart=/opt/tomcat/bin/startup.sh\nExecStop=/opt/tomcat/bin/shutdown.sh\n\nRestartSec=10\nRestart=always\n\n[Install]\nWantedBy=multi-user.target" | sudo tee /etc/systemd/system/tomcat.service > /dev/null

sudo systemctl daemon-reload

sudo systemctl start tomcat

sudo systemctl enable tomcat

sudo ufw allow 8080
