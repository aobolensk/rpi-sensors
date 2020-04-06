import nimpy
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
