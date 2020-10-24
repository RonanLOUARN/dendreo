# frozen_string_literal: true

require "spec_helper"

module Dendreo
  RSpec.describe API do
    let(:api_key) { 'testapikey' }
    let(:url) { 'https://www.testurl.com/company/api' }
    context 'when it is initialized' do
      it 'raise error when api_key is missing' do
        expect { described_class.new(url, '') }.to(
          raise_error('Veuillez renseigner une clé API')
        )
      end

      it 'raise error when url is missing' do
        expect { described_class.new('', api_key) }.to(
          raise_error('Veuillez renseigner une url ex: https://pro.dendreo.com/my_company/api')
        )
      end

      it 'raise errors when api_key and url are missing' do
        expect { described_class.new('', '') }.to(
          raise_error('Veuillez renseigner une url ex: https://pro.dendreo.com/my_company/api, Veuillez renseigner une clé API')
        )
      end
    end

    context 'when it makes a request' do
      context 'POST' do
        it 'raise errors when form_data is missing' do
          expect { described_class.new(url, api_key).call(method: :post, url_data: { test: 'ok' }) }.to(
            raise_error('La data à mettre à jour (form_data:) est manquante sur une requête :post')
          )
        end
      end

      context 'GET, POST, DELETE' do
        it 'raise errors when http method is missing' do
          expect { described_class.new(url, api_key).call(form_data: {}) }.to(
            raise_error('Veuillez renseigner une méthode de requête ex: :post, :get, :delete')
          )
        end
      end
    end
  end
end
