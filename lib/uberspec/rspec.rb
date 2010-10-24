module Uberspec
  class Rspec < Uberspec::Base

    def command
      'spec'
    end

    def all_test_files
      Dir['spec/**/*_spec.rb'] 
    end

  end
end
