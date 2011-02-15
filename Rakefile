require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "uberspec"
    gem.summary = %Q{Watchr + Rspec + Parallel Spec = Uberspec}
    gem.description = %Q{Continious Integration for Rspec using Watchr}
    gem.email = "gapeabody@gmail.com"
    gem.homepage = "http://github.com/alanpeabody/uberspec"
    gem.authors = ["Alan Peabody"]
    gem.add_dependency "watchr"
    gem.add_dependency "rspec", ">= 1.2"
    gem.add_development_dependency "rspec", "~> 2.0"
    gem.add_development_dependency "parallel_tests"
    gem.add_development_dependency "watchr"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "uberspec #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
