#!/usr/bin/env python3

import time
import board
import busio
from adafruit_htu21d import HTU21D

# Create library object using our Bus I2C port
i2c = busio.I2C(board.SCL, board.SDA)
sensor_i2c_address = None
scanning_frequency = 5
reading_frequency = 1

while True:
    print("\nScanning for I2C device address to appear\n")
    sensor_i2c_address = next(iter(i2c.scan()), None)

    if sensor_i2c_address:
        print(f"\nFound sensor address at {sensor_i2c_address}\n")
        break
    else:
        print("\nFailed to detect any connected I2C sensors. "
              f"Sleeping for {scanning_frequency} seconds before rescan...\n")
        time.sleep(scanning_frequency)

sensor = HTU21D(i2c, sensor_i2c_address)

while True:
    print("\nTemperature: %0.1f C" % sensor.temperature)
    print("Relative Humidity: %0.1f %%" % sensor.relative_humidity)
    time.sleep(reading_frequency)
