require 'uberspec/config'

module Uberspec
  class Base
    class << self
      def watch(watchr_script, config = Config.new)
        yield config if block_given?
        tester = new(watchr_script,config)
        tester.start_watching
        tester
      end

      def run_all
        ObjectSpace.each_object(self) { |o| o.run_all }
      end
    end

    attr_reader :watchr
    attr_reader :matches
    attr_reader :config

    def initialize(watchr_script,config)
      @watchr = watchr_script
      @config = config
    end

    def start_watching
      all_paths.each do |path|
        watchr.watch(path) {|m| find_and_run_match(m[1]) }
      end
    end

    def find_and_run_match(thing_to_match)
      @matches = all_test_files.grep(/#{thing_to_match}/i)
      if matches.empty?
        puts "No matches found for #{thing_to_match}"
      else
        run
      end
    end

    def all_paths
      (@config.spec_paths + @config.code_paths).uniq
    end

    def all_test_files
      raise "'all_test_files' Must be defined in test suite specific implimentation"
    end

    def command
      raise "'command' Must be defined in test suite specific implimentation"
    end

    def run_all
      @matches = all_test_files
      run
    end

    def clear
      system("clear")
    end

    def run
      clear
      system("#{command} #{matches.join(' ')}") 
    end

    Signal.trap('QUIT') { run_all } # Ctrl-\
    Signal.trap('INT' ) { abort("\n") } # Ctrl-C
  end
end

require 'uberspec/rspec'
require 'uberspec/parallel'
