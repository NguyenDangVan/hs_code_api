module Api
  module V1
    class Base < Grape::API
      include Api::V1::Default
      include Api::V1::ErrorHandler
      include Api::V1::Authentication

      # Mount API endpoints
      mount Api::V1::Auth
      mount Api::V1::HsCodes
      mount Api::V1::Favourites

      get :health do
        { status: "ok", timestamp: Time.current }
      end
    end
  end
end
