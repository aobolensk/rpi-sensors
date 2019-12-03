import os

import dht22

proc main =
  while true:
    let sensor = dht22(4)
    let data = sensor.get()
    echo "Temperature: ", data[0], ", humidity: ", data[1]
    os.sleep(1000)


when isMainModule:
  main()
