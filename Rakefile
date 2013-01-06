# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.setup
Bundler.require

require 'rubygems'
require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  app.vendor_project 'vendor/Base64', :static

  app.identifier = "com.pixopop.PixopopColoringBookVolumeOne"
  app.name = 'Pixopop Coloring Book Volume 1'
  app.device_family = [:ipad, :iphone]
  app.interface_orientations << :portrait_upside_down

  app.deployment_target = "5.0" 

  app.vendor_project 'vendor/InfColorPicker', :static

  app.development do
    app.entitlements['get-task-allow'] = true
    app.provisioning_profile = "/Users/keyvan/Library/MobileDevice/Provisioning Profiles/C3038594-1DA5-4854-BFC3-3EDC798E4DC2.mobileprovision"
    app.codesign_certificate = "iPhone Developer: Ali SABET (ANSABNN78M)"
  end
  
  app.release do
    app.entitlements['get-task-allow'] = false
    app.provisioning_profile = "/Users/keyvan/Library/MobileDevice/Provisioning Profiles/0A76B6AC-3FF1-4352-BE71-4ADC36DF0FA7.mobileprovision"
    app.codesign_certificate = "iPhone Distribution: Sabet Brands, Inc."
  end
end
