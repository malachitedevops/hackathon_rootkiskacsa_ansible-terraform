#!/bin/bash

sleep 60
sudo docker pull ncrmns/erstebackend

sudo docker-compose down

sudo docker-compose build
sudo docker-compose up -d
