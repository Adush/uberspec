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

  end
end
