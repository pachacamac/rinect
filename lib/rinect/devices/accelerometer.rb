module Rinect
  class Accelerometer
    #see http://www.kionix.com/Product%20Sheets/KXSD9%20Product%20Brief.pdf
    
    include Rinect::Device
    
    GRAVITY = 9.80665
    COUNTS_PER_G = 819.0
    
    def get   
      data = "\0" * 10
      ret = @handle.usb_control_msg 0xC0, 0x32, 0x0000, 0x0000, data, 10
		  raise "read wrong number of bytes" if ret != 10
      @state = {:x            => ((data[2][0] << 8 ) | data[3][0]).to_f / COUNTS_PER_G * GRAVITY,
                :y            => ((data[4][0] << 8 ) | data[5][0]).to_f / COUNTS_PER_G * GRAVITY,
                :z            => ((data[6][0] << 8 ) | data[7][0]).to_f / COUNTS_PER_G * GRAVITY,
                :tilt_angle   => data[8][0],
                :tilt_status  => data[9][0]}
    end
    
    def to_s
      "Current accelerometer state: #{@state.to_a.collect{|e| "#{e[0]}=#{e[1]}"}.join(', ')}"
    end
  end
end

