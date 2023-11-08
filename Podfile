platform :ios, '13.0'
use_frameworks!

def shared_pods
  pod 'Alamofire'
  pod 'Swinject'
  pod 'KeychainAccess'
end

target 'PharmaApp' do
  
  shared_pods

  target 'PharmaAppTests' do
    inherit! :search_paths
  end

  target 'PharmaAppUITests' do
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end
end
