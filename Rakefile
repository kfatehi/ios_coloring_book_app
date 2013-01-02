# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.setup
Bundler.require

Motion::Project::App.setup do |app|
  app.vendor_project 'vendor/Base64', :static

  app.identifier = "com.pixopop.PixopopColoringBookVolumeOne"
  app.name = 'Pixopop Coloring Book Volume 1'
  app.device_family = [:ipad, :iphone]
  app.interface_orientations << :portrait_upside_down

  app.deployment_target = "5.0" 

  app.provisioning_profile = "/Users/keyvan/Library/MobileDevice/Provisioning Profiles/4FFBF442-D363-4D62-9C8F-D6F4D90F1D43.mobileprovision"
  app.codesign_certificate = "iPhone Distribution: Sabet Brands, Inc."
end
