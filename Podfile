# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'MoodTracker' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MoodTracker

pod 'Firebase'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'Firebase/Core'
pod 'GoogleSignIn'
pod 'GooglePlaces'
pod 'RAMAnimatedTabBarController'
pod 'UITextField+Shake', '~> 1.1'
pod 'SCLAlertView'
pod 'IQKeyboardManagerSwift'

pod 'BEMSimpleLineGraph'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
  end



end

