module Rinect
  class LED
    include Rinect::Device
    
    LED_STATES = {
      :off => 0,
      :green => 1,
      :red => 2,
      :yellow => 3,
      :blink_yellow => 4,
      :blink_green => 5,
      :blink_red_yellow => 6,
      :blink_red_green => 7
    }
    
    def initialize
      @device ||= USB.devices.select{|d| d.idVendor==0x045e && d.idProduct==0x02b0}.first
      @handle = nil
      @state = :off
    end
  
    def connect
      begin
        @handle ||= @device.usb_open
      rescue Exception => e
        puts e.message
      end
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