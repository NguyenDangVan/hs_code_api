require 'rails_helper'

RSpec.describe 'Health API', type: :request do
  describe 'GET /api/v1/health' do
    it 'returns health status' do
      get '/api/v1/health', headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['status']).to eq('ok')
      expect(json['timestamp']).to be_present
    end
  end
end
