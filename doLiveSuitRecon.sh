#!/usr/bin/env bash

fastboot devices
# TODO Error handling. Should say `fastboot`

fastboot getvar dustversion
# TODO Error handling. Should say 2024.07.00 or newer!

fastboot getvar config | tee getvar_config_output.log


############################### STAGE 0 
fastboot get_staged dustx100.bin
# TODO Error handling:
# Should say `OKAY`
# and `du -h dustx100.bin`
# should say at least: 400M or 399M

############################### STAGE 1 
fastboot oem stage1
# TODO Error handling. Should say `OKAY`
fastboot get_staged dustx101.bin
# TODO Error handling.
# Should say `OKAY`
# and `du -h dustx101.bin`
# Should say at least: 400M or 399M


############################### STAGE 2
fastboot oem stage2
# TODO Error handling. Should say `OKAY`
fastboot get_staged dustx102.bin
# TODO Error handling.
# Should say `OKAY`
# and `du -h dustx102.bin`
# Should say at least: 400M or 399M

echo "POWEROFF ASAP!" 
echo "Hold the power button for 15s!"
echo "Also disconnect USB!"

zip dreame_rxxxx_samples.zip dustx100.bin dustx101.bin dustx102.bin getvar_config_output.log
