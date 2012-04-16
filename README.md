This is not actively developed by me anymore since I sold my Kinect. If anyone wants to continue this project I'd be happy to help out if I can.

<h1>Rinect</h1>
Rinect aims to be a <b>pure ruby</b> implementation (libusb requirement only) of a Microsoft Kinect driver. It will let you control and access all aspects of the Kinect via a Ruby interface.

Functionality is very limited right now since this project is so new, but full control is the final goal.

<h1>Requirements</h1>
* ruby-usb (https://github.com/akr/ruby-usb)

If you're running Mac OSX, this guide may help you get ruby-usb working: http://www.jedi.be/blog/2009/11/11/ruby-usb-libusb/

<h1>Current status</h1>
What we can do:

* Control the motor
* Control the LED
* Read the accelerometer

What we can not do yet:

* Read an RGB image
* Read a depth image
