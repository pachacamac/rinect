module Rinect
  class Motor
    include Rinect::Device
    
    def initialize
      @device ||= USB.devices.select{|d| d.idVendor==0x045e && d.idProduct==0x02b0}.first
      @handle = nil
      @state = :off
    end
    
    def set(state)
      throw ArgumentError, "Invalid LED state given" unless LED_STATES.has_key? state
      
      @state = state
      @handle.usb_control_msg 0x40, 0x06, LED_STATES[state], 0x0000, '', 0
    end
    
    def get
      @state
    end
    
    def to_s
      "Current LED state: #{@state.to_s}"
    end
  end
end