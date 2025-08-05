module Api
  module V1
    class Base < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      # Global error handling
      rescue_from :all do |e|
        error!({ error: e.message }, 500)
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        error!({ error: 'Record not found' }, 404)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        error!({ error: e.record.errors.full_messages }, 422)
      end

      # Mount API endpoints
      mount Api::V1::Auth
      mount Api::V1::HsCodes

      # Health check endpoint
      get :health do
        { status: 'ok', timestamp: Time.current }
      end
    end
  end
end 