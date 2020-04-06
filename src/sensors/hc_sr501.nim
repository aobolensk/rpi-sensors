import ../gpio

type HCSR501Sensor* = object
  pin: int

proc hc_sr501*(pin: cint): HCSR501Sensor =
  HCSR501Sensor(pin: pin)

proc get*(this: HCSR501Sensor): int =
  enablePin(this.pin)
  result = digitalReadPin(this.pin)
  disablePin(this.pin)

proc getString*(this: HCSR501Sensor): string =
  let data = this.get()
  if data > 0:
    result = "[HC-SR501] Motion is detected"
  else:
    result = "[HC-SR501] Motion is not detected"
