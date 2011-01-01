require 'rubygems'
require 'usb'

LED_STATES = {:off=>0, :green=>1, :red=>2, :yellow=>3, :blink_yellow=>4, :blink_green=>5, :blink_red_yellow=>6, :blink_red_green=>7}
def set_led(state)
  begin
    @@led_device ||= USB.devices.select{|d| d.idVendor==0x045e && d.idProduct==0x02b0}.first
    @@led_handle ||= @@led_device.usb_open
    @@led_handle.usb_control_msg 0x40, 0x06, state, 0x0000, '', 0
  rescue Exception => e  
    puts e.message
  end
end

def set_motor(pitch)
  begin
    @@motor_device ||= USB.devices.select{|d| d.idVendor==0x045e && d.idProduct==0x02b0}.first
    @@motor_handle ||= @@motor_device.usb_open
    pitch = -35 if pitch < -35
	  pitch = 55 if pitch > 55
    @@motor_handle.usb_control_msg 0x40,0x31,pitch,0x0000,'',0
  rescue Exception => e  
    puts e.message
  end
end

USBRQ_HID_GET_REPORT = 1
USBRQ_HID_SET_REPORT = 9
USB_HID_REPORT_TYPE_FEATURE = 3
	
def read_accelerometer
  begin
    @@led_device ||= USB.devices.select{|d| d.idVendor==0x045e && d.idProduct==0x02b0}.first
    @@led_handle ||= @@led_device.usb_open
	  #@@led_handle.usb_set_configuration(1)
	  #@@led_handle.usb_claim_interface(0)
    data = "\0"*32
    #(requesttype, request, value, index, bytes, timeout)
    data_size = @@led_handle.usb_control_msg(0x40, 0x32, USBRQ_HID_GET_REPORT,
			USB_HID_REPORT_TYPE_FEATURE << 8 | 0, data, 32)
    p data
    p data_size
    return {
      :val1 => (data[2][0] << 8 ) | data[3][0],
      :val2 => (data[4][0] << 8 ) | data[5][0],
      :val3 => (data[6][0] << 8 ) | data[7][0]
    }
  rescue Exception => e  
    puts e.message
  end
end

p read_accelerometer
set_motor rand*55
sleep 2
p read_accelerometer

#set_led(LED_STATES[:yellow])

#LED_STATES.each_pair{|k,v|
#  puts "setting state to #{k}"
#  set_led v
#  sleep 4
#}

