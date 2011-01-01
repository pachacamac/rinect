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