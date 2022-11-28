#!/bin/bash

echo "instalando herramientas para configuracion de red"
sudo apt-get install net-tools -y

echo "instalando el editor Vim"
sudo apt-get install vim -y

echo "actualización"
sudo apt update && apt upgrade -y

echo "instalando haproxy"
sudo apt install haproxy -y

echo "habilitar haproxy"
sudo systemctl enable haproxy

echo "archivo de configuración"
sudo cp --force /vagrant/haproxy.cfg /etc/haproxy/haproxy.cfg

echo "cargando página de error"
sudo cp --force /vagrant/503.http /etc/haproxy/errors/503.http
sudo cp --force /vagrant/index.css /etc/haproxy/errors

echo "iniciar el servicio de haproxy"
sudo systemctl restart haproxy

#Provisioning third virtual machine (Load Balancer with HAProxy)
