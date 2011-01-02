require '../lib/rinect'

accel = Rinect::Accelerometer.new.connect

accel.get
puts accel.to_s

