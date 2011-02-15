require 'uberspec'

Uberspec::Parallel.watch(self) do |config|
  config.code_paths += ['^lib/(.*)\.rb']
  config.spec_paths += ['^spec/(.*)\.']
  config.notify = false #'LibNotify' #'Growl' #false
end


# vim:ft=ruby
