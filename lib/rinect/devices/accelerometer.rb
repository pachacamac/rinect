module Rinect
  class Accelerometer
    include Rinect::Device

=begin
  # This is code from the C-driver of Oliver Kreylos.
  # Let's try to rebuild it in Ruby ...
  # I also looked at this code: http://www.stahlke.org/dan/usb-temperature/temp_probe.html
  void KinectMotor::readAccelerometers(float accels[3]){
	  /* Read the raw accelerometer values: */
	  unsigned char data[32];
	  size_t dataSize=readControl(0x40,0x32,0x0000,0x0000,data,sizeof(data));
	  if(dataSize>=8){
		  for(int i=0;i<3;++i){
			  int val=(int(data[i*2+2])<<8)|int(data[i*2+3]);
			  if(val>=0x8000)
				  val-=65536;
			  accels[i]=float(val);
			  }
		  }
	  else
		  Misc::throwStdErr("KinectMotor::readAccelerometers: Short control packet, received %d bytes instead of 8",int(dataSize));
  }
  #readControl is something like this then:
  #size_t USBDevice::readControl(unsigned int requestType,unsigned int request,unsigned int value,unsigned int index,unsigned char* data,size_t maxDataSize,unsigned int timeOut){ ...
  #int transferResult=libusb_control_transfer(handle,requestType|0x80U,request,value,index,const_cast<unsigned char*>(data),maxDataSize,timeOut);
  #...}
=end
  
    #FIXME: I can't manage to get any data back :/ 
    def get   
      data = "\0" * 10
      ret = @handle.usb_control_msg 0xC0, 0x32, 0x0000, 0x0000, data, 10
		  raise "read wrong number of bytes" if ret != 10
      @state = [(data[2][0] << 8 ) | data[3][0],
                (data[4][0] << 8 ) | data[5][0],
                (data[6][0] << 8 ) | data[7][0]]
    end
    
    def to_s
      "Current state: #{@state.join(', ')}"
    end
  end
end

