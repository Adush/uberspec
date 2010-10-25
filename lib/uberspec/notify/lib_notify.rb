module Uberspec
  module Notify
    class LibNotify < Uberspec::Notify::Base

      def command
        'notify-send'
      end

      def title
        "'#{super}'"
      end

      def body
        "'#{super}'"
      end

      def image
        "-i '#{super}'"
      end

    end
  end
end
