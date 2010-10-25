module Uberspec
  class Config

    IMAGE_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'img'))

    # An array of watchr patterns for spec files.
    attr_accessor :spec_paths

    # An array of watchr patterns for code files.
    attr_accessor :code_paths

    # Accessor for which notify library to use, if any.
    attr_accessor :notify

    # Image/Icon to show when all tests pass
    attr_accessor :passed_image

    # Image/Icon to show when there are pending tests
    attr_accessor :pending_image

    # Image/Icon to show when any tests fail
    attr_accessor :failed_image

    # Create new config object with default values
    def initialize
      self.spec_paths    = default_spec_paths
      self.code_paths    = default_code_paths
      self.notify        = false
      self.passed_image  = default_passed_image
      self.pending_image = default_pending_image
      self.failed_image  = default_failed_image
    end

  private

    def default_spec_paths
      ['^spec/(.*)_spec\.rb']
    end

    def default_code_paths
      ['^lib/(.*)\.rb']
    end

    def default_passed_image
      "#{IMAGE_DIR}/passed.png"
    end

    def default_failed_image
      "#{IMAGE_DIR}/failed.png"
    end

    def default_pending_image
      "#{IMAGE_DIR}/pending.png"
    end

  end
end
