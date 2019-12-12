import ../gpio

type MH_RDSensor* = object
  pin: int

proc mh_rd*(pin: cint): MH_RDSensor =
  MH_RDSensor(pin: pin)

proc get*(this: MH_RDSensor): int =
  enablePin(this.pin)
  result = digitalReadPin(this.pin)
  disablePin(this.pin)
