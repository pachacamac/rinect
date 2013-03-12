require '../lib/rinect'

#prints devices serials
Rinect::Device.get_serials()

#access first kinect device available
motor = Rinect::Motor.new(0).connect
motor.set(0)
puts motor.to_s
sleep 2

#access specified device serial
motor = Rinect::Motor.new({:devID=>'A00364A16016051A'}).connect

#access n-th device
motor = Rinect::Motor.new(0).connect

motor.set(0)
puts motor.to_s

sleep 2

motor1 = Rinect::Motor.new(1).connect

motor1.set(10)
puts motor1.to_s

sleep 2
#puts motor.read_accelerometer.inspect
