# frozen_string_literal: true

module Dendreo
  class Request
    attr_accessor :errors, :data

    def initialize(base_url:, api_key:)
      @url = base_url
      @api_key = api_key
      @errors = []
      @form_data = nil
      @url_data = nil
      @request = nil
    end

    def call(http_method:, endpoint:, args: {})
      update_data(args)
      handle_call_errors(http_method, endpoint)
      execute(
        http_method,
        endpoint,
        Requests::Url.new(@url, endpoint, @url_data, @api_key).complete_url,
        @form_data,
      )
    end

    private

    def update_data(args)
      @form_data = args&.dig(:form_data) || []
      @url_data = args&.dig(:url_data) || []
    end

    def execute(http_method, endpoint, url, options = {})
      @request = RestClient::Request.execute(
        url: url,
        method: http_method,
        payload: options,
      )
      response_json(@request)
    rescue SocketError => _e
      errors << Requests::Error.new('Veuillez renseigner une url ex: https://pro.dendreo.com/my_company/api')
    rescue RestClient::ExceptionWithResponse => e
      return response_json(e.response) if e.http_headers[:content_type] == 'application/json'

      e.to_json
    rescue => _e
      handle_call_errors(http_method, endpoint)
    end

    def response_json(result)
      JSON.parse(result == '' ? '[{}]' : result)
    end

    def handle_call_errors(http_method, endpoint)
      errors << Requests::Error.new(
        'Veuillez renseigner une méthode de requête ex: :post, :get, :delete'
      ) unless http_method

      errors << Requests::Error.new(
        'Veuillez renseigner une méthode de requête ex: :participants'
      ) unless endpoint
      return unless http_method == :post

      errors << Requests::Error.new(
        'La data à mettre à jour (form_data:) est manquante sur une requête :post'
      ) if @form_data.empty?
    end
  end
end
