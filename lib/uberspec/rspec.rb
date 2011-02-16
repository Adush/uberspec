require 'ruby-debug'

module Uberspec
  class Rspec < Uberspec::Base

    def command
      version == 2 ? 'rspec' : 'spec'
    end

    def all_test_files
      Dir['spec/**/*_spec.rb'] 
    end

    def parse_results(result_string)
      results = result_string.split("\n")
      results = results.last(4).compact.delete_if {|i| i !~ /\S/i }

      time = results.select {|r| r.match(/finished/i)}.first.match(/\d+\.\d+/)[0].to_f

      stats = results.select {|r| r.match(/examples/)}.first.split(', ').map(&:to_i)
      examples = stats[0]
      failed = stats[1]
      pending = stats[2]

      {:time => time, :examples => examples, :failed => failed, :pending => pending}
    end

  private

    def version
      @version ||= Gem.loaded_specs['rspec'].version.to_s.to_i
    end

  end
end
