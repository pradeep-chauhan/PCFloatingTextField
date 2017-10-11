Pod::Spec.new do |s|
s.name             = 'PCFloatingTextField'
s.version          = '0.1.0'
s.summary          = 'It is provinding floating textField with delegate methods'

s.description      = <<-DESC
It is provinding floating textField with delegate methods. you can also customize textField color, underline color, placeholder label and also trigger event on textField delegate method.
DESC

s.homepage         = 'https://github.com/pradeep-chauhan/PCFloatingTextField'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Pradeep Chauhan' => 'prdpchauhan4@gmail.com' }
s.source           = { :git => 'https://github.com/pradeep-chauhan/PCFloatingTextField.git', :tag => s.version.to_s }

s.ios.deployment_target = '9.0'
s.source_files = 'PCFloatingTextField/*'
#s.resources = "PCFloatingTextField/**/*.{png,jpeg,jpg,storyboard,xib}"

end
