import osproc
import strutils

type HCSR501Sensor* = object
  pin: int

proc hc_sr501*(pin: cint): HCSR501Sensor =
  HCSR501Sensor(pin: pin)

proc get*(this: HCSR501Sensor): int =
  discard execProcess("echo " & $this.pin & " > /sys/class/gpio/export")
  result = execProcess("cat /sys/class/gpio/gpio" & $this.pin & "/value").strip().parseInt()
