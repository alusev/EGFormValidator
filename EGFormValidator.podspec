Pod::Spec.new do |s|
  s.name             = 'EGFormValidator'
  s.version          = '0.4.0'
  s.summary          = 'A simple form validation library written in Swift 3.0.'
  s.description      = <<-DESC
The EGFormValidator framework allows you to validate any input field in a convenient way and to display error absolutely anywhere you want.

Availables built-in form validators:
* Mandatory
* Digits
* Minlength
* Maxlength
* Equalty
* Email

It is also extendable, so you can easily create your own input validator.

Add custom styles to highlight invalid input fields
                       DESC
  s.homepage         = 'https://github.com/alusev/EGFormValidator'

  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Evgeny Gushchin' => 'latenal@gmail.com' }
  s.source           = { :git => 'https://github.com/alusev/EGFormValidator.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Classes/*'
  s.frameworks = 'UIKit'
end
