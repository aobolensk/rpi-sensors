# Package
version       = "0.1.0"
author        = "gooddoog"
description   = "Sensor management application for Raspberry Pi"
license       = "MIT"
srcDir        = "src"
bin           = @["rpi_sensors", "server"]

# Dependencies
requires "nim >= 1.0.0"
requires "nimpy >= 0.1.0"
