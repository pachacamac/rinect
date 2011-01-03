module Rinect
  class Motor
    include Rinect::Device
    
    def set(pitch)      
      pitch = -35  if pitch < -35
      pitch = 55   if pitch > 55
      
      @handle.usb_control_msg 0x40, 0x31, pitch, 0x0000, '', 0
      
      @state = pitch
    end
    
    def get
      @state
    end
    
    def read_accelerometer
      data = " " * 10
      @handle.usb_control_msg(0xC0, 0x32, 0x0, 0x0, data, 10)

      result = {
        :x => (data[2].unpack('C') << 8) | data[3].unpack('C'),
        :y => (data[4].unpack('C') << 8) | data[5].unpack('C'),
        :z => (data[6].unpack('C') << 8) | data[7].unpack('C'),
        :tilt_angle => data[8].unpack('c'),
        :tilt_status => data[9].unpack('c')
      }
    end
    
    def to_s
      "Current pitch: #{@state.to_s}"
    end
  end
end