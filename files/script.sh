#!/bin/bash

echo "instalando herramientas para configuracion de red"
sudo apt-get install net-tools -y

echo "instalando el editor Vim"
sudo apt-get install vim -y

echo "instalando consul"
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && apt upgrade -y
sudo apt install consul -y

echo "instalando nodejs"
sudo apt install nodejs -y

echo "instalando npm"
sudo apt install npm -y

echo "clonando repositorio"
git clone https://github.com/DanielaGomez98/microproyecto1_compuNube.git
cd microproyecto1_compuNube/web1
npm install consul
npm install express
cd ../..

echo "configurando el archivo ejecutable del servicio de consul"
sudo touch consulagent
sudo cat <<TEST> consulagent
#!/bin/bash
# -*- ENCODING: UTF-8 -*-
consul agent -ui -server -bootstrap-expect=1 -data-dir=. -node=agent-one -bind=192.168.100.5 -client=0.0.0.0 -enable-script-checks=true -config-dir=/etc/consul.d
TEST
sudo chmod +x consulagent

echo "configurando el servicio de consul"
cd /etc/systemd/system
sudo touch consul.service
sudo cat <<TEST1> consul.service
[Unit]
Description=Running consul agent
[Service]
User=root
ExecStart=/home/vagrant/consulagent
[Install]
WantedBy=multi-user.target
TEST1
sudo chmod 777 consul.service

sudo systemctl daemon-reload
sudo systemctl enable consul.service
sudo systemctl restart consul.service

cd ../../..
cd home/vagrant/
cd microproyecto1_compuNube/web1
node index.js 3000 &
