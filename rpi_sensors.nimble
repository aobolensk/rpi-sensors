# Package
version       = "0.1.0"
author        = "gooddoog"
description   = "Sensor management application for Raspberry Pi"
license       = "MIT"
srcDir        = "src"
bin           = @["main", "server"]

# Dependencies
requires "nim >= 1.0.0"
requires "nimpy >= 0.1.0"

task app, "Build and run application":
  exec "nim c -r src/main.nim --hints:on --warnings:on --styleCheck:hint"

task server, "Build and run server":
  exec "nim c -r src/server.nim --hints:on --warnings:on --styleCheck:hint"
