import asynchttpserver, asyncdispatch

let server = newAsyncHttpServer()

proc serveRequest(req: Request) {.async.} =
  await req.respond(Http400, "Hello")

proc main =
  waitFor server.serve(Port(8080), serveRequest)

when isMainModule:
  main()
