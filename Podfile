# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'toufik' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for toufik
  pod 'Firebase/Analytics'
  pod 'Firebase/RemoteConfig'
  pod 'DropDown'
  pod 'SQLite.swift', '~> 0.12.0'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
    end
  end
end
