platform :ios, '13.0'

use_frameworks!

def shared_pods
  pod 'Alamofire'
  pod 'Swinject'
end

target 'PharmaApp' do

  shared_pods
  

  target 'PharmaAppTests' do
    inherit! :search_paths
  end

  target 'PharmaAppUITests' do
  end

end
