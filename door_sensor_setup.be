import path

var base_url = "https://raw.githubusercontent.com/Flobul/Tasmota-DoorSensor_ULP_DeepSleep/main/"
var files = {
  'sensor': "door_sensor.be",
  'sensor_config': "door_sensor_config.be"
}

def download_file(filename)
  var cl = webclient()
  cl.begin(base_url + filename)
  if cl.GET() != 200 return false end
  cl.write_file(filename)
  cl.close()
  return true
end

def start_door_sensor_setup()
  var success = true

  for name: files.keys()
    print(format("Downloading %s...", files[name]))
    if !download_file(files[name])
      print(format("Error downloading %s", files[name]))
      success = false
      break
    end
  end

  if success
    print("All files downloaded successfully")
    load('door_sensor.be')
    return true
  end
  return false
end

start_door_sensor_setup()
