import asynchttpserver, asyncdispatch
import sensors/dht22

let sensor = dht22(4)

let server = newAsyncHttpServer()

proc serveRequest(req: Request) {.async.} =
  {.gcsafe.}:
    let data = sensor.get()
  let dht22Response = "Temperature: " & $(data[0]) & ", humidity: " & $(data[1])
  await req.respond(Http200, dht22Response)

proc main =
  waitFor server.serve(Port(8080), serveRequest)

when isMainModule:
  main()
