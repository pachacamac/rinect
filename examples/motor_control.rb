require '../lib/rinect'

motor = Rinect::Motor.new.connect

motor.set(-30)
puts motor.to_s

sleep 2

puts motor.read_accelerometer.inspect