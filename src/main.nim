import os
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
        echo sensor.getString()
      elif x == "2":
        let sensor = hc_sr501(17)
        echo sensor.getString()
      elif x == "3":
        let sensor = mh_rd(24)
        echo sensor.getString()
      else:
        echo "Unknown sensor"
    sleep(500)

when isMainModule:
  main()
