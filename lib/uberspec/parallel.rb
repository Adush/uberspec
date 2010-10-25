module Uberspec
  class Parallel < Uberspec::Rspec

    def command
      case matches.length
      when 1
        'parallel_spec -n 1'
      when 2..4
        'parallel_spec -n 2'
      else
        'parallel_spec'
      end
    end

    def parse_results(result_string)
      results = result_string.split("\n")
      results = results[results.rindex("Results:")+1,results.length].compact.delete_if {|i| i !~ /\S/i }
      examples = 0
      pending = 0
      failed = 0
      results.each do |line|
        if line =~ /\d+ example/
          stats = line.split(',').map(&:to_i)
          examples += stats[0]
          failed += stats[1]
          pending += stats[2] if stats[2]
        end
      end

      time = results.last.match(/\d*\.\d*/)[0].to_f

      {:examples => examples, :pending => pending, :failed => failed, :time => time}
    end

  end
end
