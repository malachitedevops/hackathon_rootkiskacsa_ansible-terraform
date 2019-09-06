#!/bin/bash

sleep 60
sudo docker pull samuzad/ersteusercreator

sudo docker-compose down

sudo docker-compose build
sudo docker-compose up
