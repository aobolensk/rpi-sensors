import math
import nimpy
import strformat
import strutils
from sequtils import map

let Adafruit_DHT = pyImport("Adafruit_DHT")

type DHT22Sensor* = object
  pin: int

proc dht22*(pin: int): DHT22Sensor =
  DHT22Sensor(pin: pin)

proc get*(this: DHT22Sensor): seq[float] =
  let s = Adafruit_DHT.read_retry(Adafruit_DHT.DHT22, this.pin)
  try:
    result = ($s)[1..^2].split(", ").map(parseFloat)
  except ValueError:
    result = @[NaN, NaN]

proc getString*(this: DHT22Sensor): string =
  let data = this.get()
  if data[0].classify == fcNan or data[1].classify == fcNan:
    result = "[DHT-22] Could not retrieve temperature and humidity"
  else:
    result = fmt"[DHT-22] Temperature: {data[0]:.1f}, humidity: {data[1]:.1f}"
