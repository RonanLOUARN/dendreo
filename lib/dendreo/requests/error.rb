# frozen_string_literal: true

module Dendreo
  module Requests
    class Error < StandardError
      def initialize(msg)
        super(msg)
      end
    end
  end
end
