# frozen_String_literal: true

module Dendreo
  module Requests
    class Url
      attr_reader :complete_url

      def initialize(url, endpoint, url_data, api_key)
        @endpoint = endpoint.to_s
        @url_data = url_data
        @url = url
        @api_key = api_key
        puts build_complete_url
        @complete_url = build_complete_url
      end

      private

      def build_data_url
        @url_data.map do |k, v|
          "#{k}=#{v}"
        end.join('&')
      end

      def build_url
        return '' if @url_data&.empty?

        build_data_url
      end


      def build_complete_url
        "#{@url}/#{@endpoint}.php?key=#{@api_key}&#{build_url}"
      end
    end
  end
end