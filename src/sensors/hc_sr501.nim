import tables

{.passL: "-lwiringPi".}

type HCSR501Sensor* = object
  pin: int

proc pinMode(pin: cint, mode: cint): void {.importc.}
proc wiringPiSetup(): cint {.importc.}
proc digitalRead(pin: cint): cint {.importc.}

var wiringPiPinMapping = {
  0: 30,
  1: 31,
  2: 8,
  3: 9,
  4: 7,
  5: 21,
  6: 22,
  7: 11,
  8: 10,
  9: 13,
  10: 12,
  11: 14,
  12: 26,
  13: 23,
  14: 15,
  15: 16,
  16: 27,
  17: 0,
  18: 1,
  19: 24,
  20: 28,
  21: 29,
  22: 3,
  23: 4,
  24: 5,
  25: 6,
  26: 25,
  27: 2,
}.toTable

proc hc_sr501*(pin: cint): HCSR501Sensor =
  HCSR501Sensor(pin: wiringPiPinMapping[pin])

proc get*(this: HCSR501Sensor): int =
  if wiringPiSetup() == -1:
    echo "Unable to setup Wiring Pi"
  pinMode(this.pin.cint, 0)
  result = digitalRead(this.pin.cint)
