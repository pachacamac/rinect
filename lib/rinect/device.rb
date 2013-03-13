module Rinect
  module Device
    attr_accessor :set
    attr_reader   :connect, :get
    
    DEVICES = {
      'Rinect::LED' => 0x02b0,
      'Rinect::Motor' => 0x02b0,
      'Rinect::Accelerometer' => 0x02b0
    }
    
    def self.get_serials()
      USB.devices.each do |d|
        puts 'device'
        if(d.idVendor == 0x045e && d.idProduct==0x02b0) then
            puts d.serial_number()
        end
      end
    end
    
    def initialize(args={})
      if args.class != Fixnum && args.length == 0 then
        @device ||= USB.devices.select {|d| d.idVendor == 0x045e && d.idProduct == DEVICES[self.class.to_s] }.first
      else 
        if args.class != Fixnum && args[:devID] != nil then
          @device ||= USB.devices.select {|d| d.serial_number() == args[:devID] }.first
        else
          @device ||= USB.devices.select {|d| d.idVendor == 0x045e && d.idProduct == DEVICES[self.class.to_s]}[args]
        end
      end 
      @handle = nil
      @state = :off
    end
    
    #def initialize(devID)
    #  @device ||= USB.devices.select {|d| d.idVendor == 0x045e && d.idProduct == DEVICES[self.class.to_s] }[devID]
    #  
    #  @handle = nil
    #  @state = :off
    #end
    
    def inspect
      @device.inspect
    end
    
    def connect
      raise IOError, "Kinect not found/not connected." if @device.nil?

      @handle ||= @device.usb_open        
      self
    end
  end
end
