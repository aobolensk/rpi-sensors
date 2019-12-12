import ../gpio

type HCSR501Sensor* = object
  pin: int

proc hc_sr501*(pin: cint): HCSR501Sensor =
  HCSR501Sensor(pin: pin)

proc get*(this: HCSR501Sensor): int =
  enablePin(this.pin)
  result = digitalReadPin(this.pin)
  disablePin(this.pin)
