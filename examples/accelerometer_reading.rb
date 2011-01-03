require '../lib/rinect'

accel = Rinect::Accelerometer.new.connect
motor = Rinect::Motor.new.connect

motor.set(0)
sleep 3
puts motor.to_s
accel.get
puts accel.to_s
sleep 3

motor.set(-35)
sleep 3
puts motor.to_s
accel.get
puts accel.to_s
sleep 3

motor.set(55)
sleep 3
puts motor.to_s
accel.get
puts accel.to_s
sleep 3

motor.set(0)