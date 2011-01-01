module Rinect
  module Device
    attr_accessor :set
    attr_reader   :connect, :get
    
    def initialize
      @device ||= USB.devices.select{|d| d.idVendor==0x045e && d.idProduct==0x02b0}.first
      @handle = nil
      @state = :off
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