require "dendreo/version"
require "json"
require 'net/http'
require "rest-client"
module Dendreo
  class API
    attr_accessor :url
    attr_accessor :api_key

    def initialize(url, api_key)
      @url = url #exemple = https://pro.dendreo.com/my_company/api
      @api_key = api_key
    end

    def method_missing(method_name, *args)
      method_name_string = method_name.to_s
      request_method = args.first[:method]
      datas = args.any? ? args.first[:datas] : {}
      base_url = "#{@url}/#{method_name_string}.php?key=#{@api_key}"
      case request_method
      when "get"
        send_it(:get, "#{base_url}#{format_args_to_url(datas)}")
      when "post"
        send_it(:post, "#{base_url}", datas)
      when "delete"
        send_it(:delete, "#{base_url}#{format_args_to_url(datas)}")
      else
        raise "Méthode inconnue '#{request_method}' !"
      end
    end

    private

    def send_it(http_method, url, options = {})
      hsh = {url: url, method: http_method }
      hsh.merge!(payload: options) if http_method == :post
      response_json(RestClient::Request.execute(hsh))
    end

    def format_args_to_url(args = {})
      args.any? ? args.map{|k, v| k == args.keys.first ? "&#{k}=#{v}" : "#{k}=#{v}" }.join("&") : ""
    end

    def response_json(result)
      JSON.parse(result == "" ? "[{}]" : result)
    end
  end
end
