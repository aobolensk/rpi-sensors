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
        response &= sensor.getString() & '\n'
    block hc_sr501:
      let sensor = hc_sr501(17)
      {.gcsafe.}:
        response &= sensor.getString() & '\n'
    block mh_rd:
      let sensor = mh_rd(24)
      {.gcsafe.}:
        response &= sensor.getString() & '\n'
    await req.respond(Http200, response)
  else:
    await req.respond(Http404, "Not found")

proc main =
  waitFor server.serve(Port(8080), serveRequest)

when isMainModule:
  main()
