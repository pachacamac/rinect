module Rinect; end

# Helper for Rails < 1.9.x
def require_local(path)
  require(File.expand_path(File.join(File.dirname(__FILE__), path)))
end

# Include standard libraries
require 'rubygems'
require 'usb'

# Include Rinect files
require_local 'rinect/device'
require_local 'rinect/devices/led'
require_local 'rinect/devices/motor'
require_local 'rinect/devices/accelerometer'

