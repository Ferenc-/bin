import pyudev

context = pyudev.Context()

device_filter = {
    'subsystem': 'tty', # AT interfaces are exposed on serial tty devices
    'ID_VENDOR_ID': '2c7c', # Only Quectel devices are tested (EC-25 & EG-25)
    'ID_MM_PORT_TYPE_AT_PRIMARY': '1' # Select the primary AT interface port
}

for device in context.list_devices(device_filter):
  print(device)
