# frozen_string_literal: true

require 'byebug'
require 'dendreo/version'
require 'dendreo/requests/error'
require 'dendreo/requests/url'
require 'dendreo/request'
require 'json'
require 'rest-client'

module Dendreo
  class API
    attr_accessor :url, :api_key, :errors, :result

    def initialize(url, api_key)
      @url = url # https://pro.dendreo.com/my_company/api
      @api_key = api_key
      @request = Request.new(base_url: @url, api_key: @api_key)
      @errors = @request.errors
      @result = nil
      handle_errors
    end

    def method_missing(method_name, *args)
      @errors = []
      @result = @request.call(
        http_method: args.first[:method],
        endpoint: method_name,
        args: args.first,
      )
      handle_errors
      @result
    end

    private

    def handle_errors
      handle_init_errors
      @errors += @request.errors
      return if @errors.empty?

      raise Requests::Error.new(@errors.map(&:message).join(', '))
    end

    def handle_init_errors
      errors << Requests::Error.new(
        'Veuillez renseigner une url ex: https://pro.dendreo.com/my_company/api'
      ) if @url.nil? or @url == ''

      errors << Requests::Error.new(
        'Veuillez renseigner une clé API'
      ) if @api_key.nil? or @api_key == ''
    end
  end
end
