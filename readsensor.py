#!/usr/bin/env python3

import time
import board
import busio
from adafruit_htu21d import HTU21D
 
# Create library object using our Bus I2C port
i2c = busio.I2C(board.SCL, board.SDA)
sensor = HTU21D(i2c, 64)
 
 
while True:
    print("\nTemperature: %0.1f C" % sensor.temperature)
    print("Relative Humidity: %0.1f %%" % sensor.relative_humidity)
    time.sleep(2)
