#!/bin/bash
apt-get -y install ${webserver}
service ${webserver} start