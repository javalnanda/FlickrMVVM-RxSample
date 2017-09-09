# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FlickrGallery' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'SDWebImage', '~> 4.0'
  pod 'MBProgressHUD', '~> 1.0.0'
  pod 'RxSwift'
  pod 'RxCocoa'

  target 'FlickrGalleryTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

# Disable Code Coverage for Pods projects
post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
        end
    end
end
