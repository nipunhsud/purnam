module Turbo
  module Extensions
    extend ActiveSupport::Concern

    class_methods do
      # Makes sure that certain pages are only accessible via turbo_stream requests
      def turbo_only(...)
        before_action(:require_turbo_stream_format, ...)
      end
    end

    private
      def require_turbo_stream_format
        raise ArgumentError, "Format error: Only accessible via Turbo." unless request.format.turbo_stream?
      end
  end
end
