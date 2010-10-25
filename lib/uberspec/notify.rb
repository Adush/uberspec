module Uberspec
  module Notify
    class Base
      attr_reader :stats
      attr_reader :failure_image
      attr_reader :passing_image

      def initialize(pass_img,fail_img)
        @passing_image = pass_img
        @failure_image = fail_img
      end

      def notify(stats = {})
        @stats = stats
        system("#{command} #{title} #{body} #{image}")
      end

      def title
        failed ? "Tests Failed!" : "Tests Passed!"
      end

      def body
        %Q{
#{stats[:examples]} Examples
#{stats[:failed]} Failed
#{stats[:pending]} Pending

Tests took #{stats[:time]} seconds
        }
      end

      def command
        raise "'command' Must be defined by notification library"
      end

      def image
        failed ? failure_image : passing_image
      end

    private
      
      def failed
        stats[:failed] > 0
      end
    end
  end
end

require 'uberspec/notify/lib_notify'
require 'uberspec/notify/growl'
