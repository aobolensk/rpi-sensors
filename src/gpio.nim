import strutils

proc enablePin*(pin: int): void =
  try:
    let f = open("/sys/class/gpio/export", fmWrite)
    defer: f.close()
    f.write($pin)
  except IOError:
    echo getCurrentExceptionMsg()

proc disablePin*(pin: int): void =
  try:
    let f = open("/sys/class/gpio/unexport", fmWrite)
    defer: f.close()
    f.write($pin)
  except IOError:
    echo getCurrentExceptionMsg()

proc digitalReadPin*(pin: int): int =
  try:
    let f = open("/sys/class/gpio/gpio" & $pin & "/value", fmRead)
    defer: f.close()
    result = f.readLine().parseInt()
  except IOError:
    echo getCurrentExceptionMsg()
