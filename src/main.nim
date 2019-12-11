import os

import sensors/dht22
import sensors/hc_sr501

proc main =
  while true:
    let sensor = hc_sr501(4)
    let data = sensor.get()
    if data > 0:
      echo "Motion is detected"
    else:
      echo "Motion is not detected"
    os.sleep(500)

when isMainModule:
  main()
