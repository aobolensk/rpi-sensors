import os
import strutils

import sensors/dht22
import sensors/hc_sr501
import sensors/mh_rd

proc main =
  echo "Select connected sensor:"
  echo "[1] DHT-22"
  echo "[2] HC-SR501"
  echo "[3] MH-RD"
  stdout.write("> ")
  let s = readLine(stdin).split()
  while true:
    for x in s:
      if x == "1":
        let sensor = dht22(4)
        let data = sensor.get()
        echo "[DHT-22] Temperature: ", data[0], ", humidity: ", data[1]
      elif x == "2":
        let sensor = hc_sr501(17)
        let data = sensor.get()
        if data > 0:
          echo "[HC-SR501] Motion is detected"
        else:
          echo "[HC-SR501] Motion is not detected"
      elif x == "3":
        let sensor = mh_rd(24)
        let data = sensor.get()
        if data > 0:
          echo "[MH-RD] Rain is not detected"
        else:
          echo "[MH-RD] Rain is detected"
      else:
        echo "Unknown sensor"
    sleep(500)

when isMainModule:
  main()
