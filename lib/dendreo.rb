require "dendreo/version"
require "restclient"

module Dendreo
  class API
    attr_accessor :url
    attr_accessor :api_key
    def initialize(url, api_key)
      @url = url #exemple = https://pro.dendreo.com/my_company/api
      @api_key = api_key
    end

    def method_missing(method_name, *args)
      puts 'salope'
      case args[:method]
      when :get
        args_formatted = format_args_to_url(args[:datas])
        get("#{@url}/#{method_name}.php?#{@api_key}&#{args_formatted}")
      when :post
        post("#{@url}/#{method_name}.php?#{@api_key}", args[:datas])
      end
    end

    def module_catgories_show(args = {})
      args_formatted = format_args_to_url(args)
      get("#{@url}/categories_module.php?#{@api_key}&#{args_formatted}")
    end


    private

    def post( url, options = {})
      RestClient::Request.execute(method: post,
        url: url ,
        payload: options
      )
    end

    def get(url)
      result = RestClient.get(url)
      res = result == "" ? "[{}]" : result
      JSON.parse(res)
    end

    def format_args_to_url(args = {})
      args.any? ? args.map{|k, v| "#{k}=#{v}" }.join("&") : ""
    end




    # def products_catgories_show(args = {})
    #   args_formatted = format_args_to_url(args)
    #   get("#{@url}/categories_produit.php?#{@api_key}&#{args_formatted}")
    # end

    # def modules_show(args = {})
    #   args_formatted = format_args_to_url(args)
    #   get("#{@url}/modules.php?#{@api_key}&#{args_formatted}")
    # end

    # def instructors_show(args = {})
    #   args_formatted = format_args_to_url(args)
    #   get("#{@url}/formateurs.php?#{@api_key}&#{args_formatted}")
    # end

    # def companies_show(args = {})
    #   args_formatted = format_args_to_url(args)
    #   get("#{@url}/entreprises.php?#{@api_key}&#{args_formatted}")
    # end

    # def companies_add(args = {})
    #   post("#{@url}/entreprises.php?#{@api_key}", args)
    # end

    # def contacts_show(args = {})
    #   args_formatted = format_args_to_url(args)
    #   get("#{@url}/contacts.php?#{@api_key}&#{args_formatted}")
    # end
  end
end
