require 'rails_helper'

RSpec.describe 'Favourites API', type: :request do
  let!(:user) { User.create(email: 'test@example.com', password: 'password123') }
  let!(:hs_code) { HsCode.create(code: '123456', description: 'Test Product', category: 'Electronics', unit: 'pcs', rate: 10.0) }
  let(:token) { JwtService.encode(user_id: user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe 'GET /api/v1/favourites' do
    context 'with valid token' do
      it 'returns user favourites' do
        get '/api/v1/favourites', headers: headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['favourites']).to be_present
        expect(json['pagination']).to be_present
      end

      it 'returns paginated results' do
        get '/api/v1/favourites', params: { page: 1, per_page: 10 }, headers: headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['pagination']['current_page']).to eq(1)
        expect(json['pagination']['per_page']).to eq(10)
      end
    end

    context 'without token' do
      it 'returns unauthorized' do
        get '/api/v1/favourites'

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /api/v1/favourites' do
    context 'with valid token' do
      it 'adds HS code to favourites' do
        post '/api/v1/favourites', params: { hs_code_id: hs_code.id }, headers: headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['message']).to eq('HS Code added to favourites successfully')
        expect(json['favourite']).to be_present
      end

      it 'returns error for duplicate favourite' do
        Favourite.create(user: user, hs_code: hs_code)
        post '/api/v1/favourites', params: { hs_code_id: hs_code.id }, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'without token' do
      it 'returns unauthorized' do
        post '/api/v1/favourites', params: { hs_code_id: hs_code.id }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/v1/favourites/:hs_code_id' do
    context 'with valid token' do
      it 'removes HS code from favourites' do
        Favourite.create(user: user, hs_code: hs_code)
        delete "/api/v1/favourites/#{hs_code.id}", headers: headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['message']).to eq('HS Code removed from favourites successfully')
      end

      it 'returns error for non-existent favourite' do
        delete "/api/v1/favourites/#{hs_code.id}", headers: headers

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'without token' do
      it 'returns unauthorized' do
        delete "/api/v1/favourites/#{hs_code.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/favourites/:hs_code_id' do
    context 'with valid token' do
      it 'returns true when HS code is favourited' do
        Favourite.create(user: user, hs_code: hs_code)
        get "/api/v1/favourites/#{hs_code.id}", headers: headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['is_favourited']).to be true
      end

      it 'returns false when HS code is not favourited' do
        get "/api/v1/favourites/#{hs_code.id}", headers: headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['is_favourited']).to be false
      end
    end

    context 'without token' do
      it 'returns unauthorized' do
        get "/api/v1/favourites/#{hs_code.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
