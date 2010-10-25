module Uberspec
  class Rspec < Uberspec::Base

    def command
      'spec'
    end

    def all_test_files
      Dir['spec/**/*_spec.rb'] 
    end

    def parse_results(result_string)
      results = result_string.split("\n")
      results = results.last(4).compact.delete_if {|i| i !~ /\S/i }

      time = results[0].match(/\d+\.\d+/)[0].to_f

      stats = results[1].split(', ').map(&:to_i)
      examples = stats[0]
      failed = stats[1]
      pending = stats[2]

      {:time => time, :examples => examples, :failed => failed, :pending => pending}
    end

  end
end
