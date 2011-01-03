module Rinect
  class Accelerometer
    #see http://www.kionix.com/Product%20Sheets/KXSD9%20Product%20Brief.pdf
    
    include Rinect::Device
    
    GRAVITY = 9.80665
    COUNTS_PER_G = 819.0
    JOINT_STATES = {
      0 => :stopped,
      1 => :at_limit,
      4 => :moving
    }
    
    def get   
      data = "\0" * 10
      ret = @handle.usb_control_msg 0xC0, 0x32, 0x0000, 0x0000, data, 10
		  raise "read wrong number of bytes" if ret != 10
		  
      @state = {:x            => ((data[2].unpack('c').first << 8 ) | data[3].unpack('c').first).to_f / COUNTS_PER_G * GRAVITY,
                :y            => ((data[4].unpack('c').first << 8 ) | data[5].unpack('c').first).to_f / COUNTS_PER_G * GRAVITY,
                :z            => ((data[6].unpack('c').first << 8 ) | data[7].unpack('c').first).to_f / COUNTS_PER_G * GRAVITY,
                :tilt_angle   => data[8].unpack('c').first,
                :tilt_status  => JOINT_STATES[data[9].unpack('C').first]}
    end
    
    def to_s
      "Current accelerometer state: #{@state.to_a.collect{|e| "#{e[0]}=#{e[1]}"}.join(', ')}"
    end
  end
end

