module Uberspec
  module Notify
    class Growl < Uberspec::Notify::Base

      def command
        'growlnotify'
      end

      def title
        "-t '#{super}'"
      end

      def body
        "-m '#{super}'"
      end

      def image
        "--image '#{super}'"
      end

    end
  end
end
