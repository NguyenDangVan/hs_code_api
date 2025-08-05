require 'rails_helper'

RSpec.describe 'Auth API', type: :request do
  describe 'POST /api/v1/auth/register' do
    let(:valid_params) do
      {
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      }
    end

    it 'registers a new user' do
      post '/api/v1/auth/register', params: valid_params, headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['message']).to eq('User registered successfully')
      expect(json['token']).to be_present
      expect(json['user']['data']['attributes']['email']).to eq('test@example.com')
    end

    it 'returns error for invalid params' do
      post '/api/v1/auth/register', params: {
        email: 'invalid-email',
        password: '123',
        password_confirmation: '123'
      }, headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe 'POST /api/v1/auth/login' do
    # rubocop:disable RSpec/LetSetup
    # User needs to exist before running login tests
    let!(:user) { User.create(email: 'test@example.com', password: 'password123') }
    # rubocop:enable RSpec/LetSetup

    it 'logs in successfully' do
      post '/api/v1/auth/login', params: {
        email: 'test@example.com',
        password: 'password123'
      }, headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['message']).to eq('Login successful')
      expect(json['token']).to be_present
    end

    it 'returns error for invalid credentials' do
      post '/api/v1/auth/login', params: {
        email: 'test@example.com',
        password: 'wrongpassword'
      }, headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
