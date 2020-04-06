import ../gpio

type MH_RDSensor* = object
  pin: int

proc mh_rd*(pin: cint): MH_RDSensor =
  MH_RDSensor(pin: pin)

proc get*(this: MH_RDSensor): int =
  enablePin(this.pin)
  result = digitalReadPin(this.pin)
  disablePin(this.pin)

proc getString*(this: MH_RDSensor): string =
  let data = this.get()
  if data > 0:
    result = "[MH-RD] Water is not detected"
  else:
    result = "[MH-RD] Water is detected"
