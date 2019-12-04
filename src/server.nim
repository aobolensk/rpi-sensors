import asynchttpserver, asyncdispatch
import dht22

let sensor = dht22(4)

let server = newAsyncHttpServer()

proc serveRequest(req: Request) {.async.} =
  {.gcsafe.}:
    let data = sensor.get()
  let dht22Responce = "Temperature: " & $(data[0]) & ", humidity: " & $(data[1])
  await req.respond(Http400, dht22Responce)

proc main =
  waitFor server.serve(Port(8080), serveRequest)

when isMainModule:
  main()
