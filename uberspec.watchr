require 'uberspec'

Uberspec::Rspec.watch(self) do |config|
  config.code_paths += ['^lib/(.*)\.rb']
  config.spec_paths += ['^spec/(.*)\.']
  # config.notify 'notify-send' #'growl' #false
end


# vim:ft=ruby
