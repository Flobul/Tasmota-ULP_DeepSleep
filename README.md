# Door Sensor (Berry) – Tasmota ESP32 ULP + Deep Sleep

Berry script for ESP32/Tasmota:
- **Normal mode**: initializes the ULP (Ultra Low Power) program to monitor a GPIO (door sensor), then enters **deep sleep** quickly.
- **Config mode**: if Wi-Fi is not configured or the BOOT button (GPIO0) is pressed, the device stays awake to allow configuration and (optionally) shows door state via a **lightweight Web UI**.

## Files
- `door-sensor.be`: main script
- `door-sensor.config.be`: optional config override file

## Settings
In `door-sensor.config.be`:

- `DOOR_GPIO` (int): door sensor GPIO (e.g. 33)
- `CONFIG_GPIO` (int): config button GPIO (often `0` on ESP32 = BOOT)
- `SLEEP_DELAY_S` (int/float): delay before deep sleep, in seconds
- `WEBUI_IN_CONFIG` (bool): enable the mini Web UI only in config mode

## Config mode (AP / button)
The script enters config mode if:
- Wi-Fi is not configured, **or**
- `CONFIG_GPIO` is low (button pressed on pull-up input)

In config mode:
- **no deep sleep**
- Web UI is available if `WEBUI_IN_CONFIG=true`

## Installation (example)
1. Copy `door-sensor.be` to the device (Tasmota filesystem).
2. (Optional) Copy `door-sensor.config.be` and adjust values.
3. Configure Tasmota to run the script at boot (Berry autoexec / rules / your preferred method).

## Technical notes
- The ULP program is embedded as base64 and uses `ULP.set_mem(55, ...)` and `ULP.set_mem(56, ...)` exactly like the original version.  
  If you change the ULP program, these offsets may need to change.
- Check your sensor wiring (pull-up/pull-down) and expected logic level (OPEN/CLOSED).

## License
Choose a license (MIT is a common choice for easy sharing).
