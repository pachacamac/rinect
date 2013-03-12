require '../lib/rinect'

motor = Rinect::Motor.new(0).connect
accel = Rinect::Accelerometer.new(0).connect

motor.set(0)
p motor.to_s
accel.get
p accel.to_s
sleep 3

motor.set(-10)
sleep 3
p motor.to_s
accel.get
p accel.to_s
sleep 3

motor.set(10)
sleep 3
p motor.to_s
accel.get
p accel.to_s
sleep 3

motor.set(0)