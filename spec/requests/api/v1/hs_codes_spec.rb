require 'rails_helper'

RSpec.describe 'HS Codes API', type: :request do
  let!(:hs_code) { HsCode.create(code: '123456', description: 'Test Product', category: 'Electronics', unit: 'pcs', tariff_rate: 10.0) }

  describe 'GET /api/v1/hs_codes' do
    it 'returns list of HS codes' do
      get '/api/v1/hs_codes', headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['hs_codes']).to be_present
      expect(json['pagination']).to be_present
    end

    it 'returns filtered results with search' do
      get '/api/v1/hs_codes', params: { search: 'Test' }, headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['hs_codes']).to be_present
    end

    it 'returns paginated results' do
      get '/api/v1/hs_codes', params: { page: 1, per_page: 10 }, headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['pagination']['current_page']).to eq(1)
      expect(json['pagination']['per_page']).to eq(10)
    end
  end

  describe 'GET /api/v1/hs_codes/:id' do
    it 'returns specific HS code' do
      get "/api/v1/hs_codes/#{hs_code.id}", headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data']['id']).to eq(hs_code.id.to_s)
      expect(json['data']['attributes']['code']).to eq('123456')
    end

    it 'returns 404 for non-existent HS code' do
      get '/api/v1/hs_codes/999999', headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:not_found)
    end
  end
end
