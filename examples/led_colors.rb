require '../lib/rinect'

led = Rinect::LED.new
led.connect
led.set(:green)