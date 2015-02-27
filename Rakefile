# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'RaiseMan'
  app.info_plist['NSMainNibFile'] = 'MainMenu'
  app.info_plist['CFBundleDocumentTypes'] = [
    {
    "CFBundleTypeExtensions" => ["rsm"],
    "CFBundleTypeIconFile" => "",
    "CFBundleTypeName" => "DocumentType",
    "CFBundleTypeOSTypes" => ['????'],
    "CFBundleTypeRole" => 'Editor',
    "NSDocumentClass" => 'Document'
    }
  ]
end
