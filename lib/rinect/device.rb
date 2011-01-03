module Rinect
  module Device
    attr_accessor :set
    attr_reader   :connect, :get
    
    def initialize
      # TODO: we need to refactor this because the kinect cam contains actually three devices.
      #       lsusb | grep Microsoft: 
      #         Bus 001 Device 007: ID 045e:02ae Microsoft Corp. 
      #         Bus 001 Device 006: ID 045e:02ad Microsoft Corp. 
      #         Bus 001 Device 005: ID 045e:02b0 Microsoft Corp. 
      #       Only the Motor-/LED-/Accel-device has the product id 0x02b0
      #       I guess the other two are RGB- and depth cam.
    
      @device ||= USB.devices.select{|d| d.idVendor==0x045e && d.idProduct==0x02b0}.first
      @handle = nil
      @state = :off
    end
    
    def inspect
      @device.inspect
    end
    
    def connect
      begin
        @handle ||= @device.usb_open
        
        self
      rescue Exception => e
        puts e.message
      end
    end
  end
end
