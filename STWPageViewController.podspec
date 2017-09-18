Pod::Spec.new do |s|

  s.name         = "STWPageViewController"
  s.version      = "0.1.0"
  s.summary      = "STWPageViewController allow to create a controllers container (UIPageViewController) quickly and easily, it is managed by a customizable toolbar. "
  s.description  = <<-DESC
STWPageViewController allow to create a controllers container (UIPageViewController) quickly and easily, it is managed by a customizable toolbar. STWPageViewcontroller can be loaded either alone or in a UINavigationController, the toolbar will automatically adapt to display needs.
                   DESC

  s.homepage     = "https://github.com/SteeweGriffin/STWPageViewController"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "Raffaele Cerullo" => "me@steewe.com" }

  s.source       = { :git => "https://github.com/SteeweGriffin/STWPageViewController.git", :tag => s.version }

  s.source_files = "STWPageViewController/*.swift"
  s.requires_arc = true
  s.ios.deployment_target = '9.0'
end
