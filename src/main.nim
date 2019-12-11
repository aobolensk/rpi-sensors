import os

import sensors/dht22
import sensors/hc_sr501

proc main =
  echo "Select connected sensor:"
  echo "[1] DHT-22"
  echo "[2] HC-SR501"
  stdout.write("> ")
  let s = readLine(stdin)
  if s == "1":
    while true:
      let sensor = dht22(4)
      let data = sensor.get()
      echo "Temperature: ", data[0], ", humidity: ", data[1]
      os.sleep(1000)
  elif s == "2":
    while true:
      let sensor = hc_sr501(4)
      let data = sensor.get()
      if data > 0:
        echo "Motion is detected"
      else:
        echo "Motion is not detected"
      os.sleep(500)
  else:
    echo "Unknown sensor"

when isMainModule:
  main()
