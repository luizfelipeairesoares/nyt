# Uncomment the next line to define a global platform for your project
platform :ios, '12.2'
inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'

target 'nyt-foil' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for nyt-foil

  # API
  pod 'Moya', '~> 13.0'
  
  #UI
  pod 'Kingfisher', '~> 5.0'
  pod 'NVActivityIndicatorView'

  target 'nyt-foilTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
   end
  end
end
