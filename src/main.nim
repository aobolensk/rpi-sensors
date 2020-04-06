import math
import os
import strformat
import strutils

import sensors/dht22
import sensors/hc_sr501
import sensors/mh_rd

proc main =
  echo "Select connected sensor:"
  echo "[1] DHT-22   < temperature sensor"
  echo "[2] HC-SR501 < motion sensor"
  echo "[3] MH-RD    < water sensor"
  stdout.write("> ")
  let s = readLine(stdin).split()
  while true:
    for x in s:
      if x == "1":
        let sensor = dht22(4)
        let data = sensor.get()
        if data[0].classify == fcNan or data[1].classify == fcNan:
          echo "[DHT-22] Could not retrieve temperature and humidity"
        else:
          echo fmt"[DHT-22] Temperature: {data[0]:.1f}, humidity: {data[1]:.1f}"
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
          echo "[MH-RD] Water is not detected"
        else:
          echo "[MH-RD] Water is detected"
      else:
        echo "Unknown sensor"
    sleep(500)

when isMainModule:
  main()
