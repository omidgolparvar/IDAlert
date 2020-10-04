Pod::Spec.new do |s|
  s.name                  = 'IDAlert'
  s.version               = '3.1.1'
  s.summary               = 'IDAlert: یه سری کارا روی آلرت‌کنترلر کردم که استفاده‌اش رو برای زبان پارسی بهتر و قشنگ‌تر و بهینه‌تر کنه.'
  s.description           = 'IDAlert: یه سری کارا روی آلرت‌کنترلر کردم که استفاده‌اش رو برای زبان پارسی بهتر و قشنگ‌تر و بهینه‌تر کنه.'
  s.homepage              = 'https://github.com/omidgolparvar/IDAlert'
  s.license               = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author                = { 'Omid Golparvar' => 'iGolparvar@gmail.com' }
  s.source                = { :git => "https://github.com/omidgolparvar/IDAlert.git", :tag => s.version.to_s }
  s.swift_version         = '5.0'
  s.platform              = :ios, '10.0'
  s.requires_arc          = true
  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig   = { 'SWIFT_VERSION' => '5.0' }
  s.source_files          = 'IDAlertController/Sources/*.{h,swift}'
end
