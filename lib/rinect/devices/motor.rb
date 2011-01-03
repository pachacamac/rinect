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
    
    def to_s
      "Current pitch: #{@state.to_s}"
    end
  end
end