import asyncdispatch
import asynchttpserver
import math
import strformat

import sensors/dht22
import sensors/hc_sr501
import sensors/mh_rd

let server = newAsyncHttpServer()

proc serveRequest(req: Request) {.async.} =
  if req.url.path == "/":
    var response = ""
    block dht22:
      let sensor = dht22(4)
      {.gcsafe.}:
        let data = sensor.get()
      if data[0].classify == fcNan or data[1].classify == fcNan:
        response &= "[DHT-22] Could not retrieve temperature and humidity\n"
      else:
        response &= fmt"[DHT-22] Temperature: {data[0]:.1f}, humidity: {data[1]:.1f}{'\n'}"
    block hc_sr501:
      let sensor = hc_sr501(17)
      let data = sensor.get()
      if data > 0:
        response &= "[HC-SR501] Motion is detected\n"
      else:
        response &= "[HC-SR501] Motion is not detected\n"
    block mh_rd:
      let sensor = mh_rd(24)
      let data = sensor.get()
      if data > 0:
        response &= "[MH-RD] Water is not detected\n"
      else:
        response &= "[MH-RD] Water is detected\n"
    await req.respond(Http200, response)
  else:
    await req.respond(Http404, "Not found")

proc main =
  waitFor server.serve(Port(8080), serveRequest)

when isMainModule:
  main()
