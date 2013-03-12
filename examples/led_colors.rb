require '../lib/rinect'

led = Rinect::LED.new(0).connect

led.set(:red)
puts led.to_s

sleep 2

led.set(:green)
puts led.to_s

sleep 2

led.set(:blink_red_yellow)
puts led.to_s

sleep 2

led.set(:green)
