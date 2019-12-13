import asynchttpserver, asyncdispatch

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
      response &= "[DHT-22] Temperature: " & $(data[0]) & ", humidity: " & $(data[1]) & '\n'
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
        response &= "[MH-RD] Rain is not detected\n"
      else:
        response &= "[MH-RD] Rain is detected\n"
    await req.respond(Http200, response)
  else:
    await req.respond(Http404, "Not found")

proc main =
  waitFor server.serve(Port(8080), serveRequest)

when isMainModule:
  main()
