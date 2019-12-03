import os
import nimpy

let Adafruit_DHT = pyImport("Adafruit_DHT")

proc main =
  while true:
    let device = Adafruit_DHT.DHT22
    let sensors = Adafruit_DHT.read_retry(device, 4)
    echo "Temperature: ", sensors[0], ", humidity: ", sensors[1]
    os.sleep(1000)


when isMainModule:
  main()
