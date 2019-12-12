import strutils

proc enablePin*(pin: int): void =
  let f = open("/sys/class/gpio/export", fmWrite)
  defer: f.close()
  f.write($pin)

proc digitalReadPin*(pin: int): int =
  let f = open("/sys/class/gpio/gpio" & $pin & "/value", fmRead)
  defer: f.close()
  result = f.readLine().parseInt()
