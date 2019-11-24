#!/usr/bin/env bash

# https://learn.adafruit.com/circuitpython-on-any-computer-with-ft232h/linux

# source the virtualenv activation first
virtualenv /tmp/ft232h
source /tmp/ft232h/bin/activate

#Unfortunately the current latest v0.40 series seems to be broken
#pip3 install pyftdi adafruit-blinka
pip3 install https://codeload.github.com/eblot/pyftdi/tar.gz/v0.30.3 adafruit-blinka

# For the temperature / humidity sensor
pip3 install adafruit-circuitpython-htu21d

export BLINKA_FT232H=1
python3 -c 'from pyftdi.ftdi import Ftdi
            Ftdi().open_from_url("ftdi:///?")'
