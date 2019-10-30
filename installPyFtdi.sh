#!/usr/bin/env bash

# https://learn.adafruit.com/circuitpython-on-any-computer-with-ft232h/linux
# source the virtualenv activation first

pip3 install pyftdi adafruit-blinka

export BLINKA_FT232H=1
python3 -c 'from pyftdi.ftdi import Ftdi
            Ftdi().open_from_url("ftdi:///?")'
