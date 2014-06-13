#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "JCBouncyMenu"
  s.version          = File.read('VERSION')
  s.summary          = "JCBouncyMenu provides a menu of buttons. Just give it an array of image names and a point and it will take it from there."
  s.description      = <<-DESC
                       JCBouncyMenu uses Facebook's Pop animation framework to provide some fun animations to its custom menu. 

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/jfclifton/JCBouncyMenu"
  s.screenshots      = ""
  s.license          = 'MIT'
  s.author           = { "Jordan Clifton" => "jfc1254@gmail.com" }
  s.source           = { :git => "https://github.com/jfclifton/JCBouncyMenu.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Jordan_Clifton'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/**/*.{h,m}'
  s.resources = 'Assets/*.png'

  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'pop'
  s.dependency 'pop', '~> 1.0'
end
