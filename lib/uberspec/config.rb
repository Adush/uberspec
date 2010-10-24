module Uberspec
  class Config

    # An array of watchr patterns for spec files.
    attr_accessor :spec_paths

    # An array of watchr patterns for code files.
    attr_accessor :code_paths

    # Accessor for weather to run in parallel or not.
    attr_accessor :parallel

    # Accessof for which notify library to use, if any.
    attr_accessor :notify

    # Create new config object with default values
    def initialize
      self.spec_paths = default_spec_paths
      self.code_paths = default_code_paths
      self.parallel   = false
      self.notify     = false
    end

  private

    def default_spec_paths
      ['^spec/(.*)_spec\.rb']
    end

    def default_code_paths
      ['^lib/(.*)\.rb']
    end
  end
end
