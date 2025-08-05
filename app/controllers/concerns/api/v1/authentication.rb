module Api
  module V1
    module Authentication
      extend ActiveSupport::Concern

      included do
        helpers do
          def authenticate_user!
            token = headers["Authorization"]&.split(" ")&.last
            error!({ error: "Token is missing" }, 401) unless token

            begin
              payload = JwtService.decode(token)
              @current_user = User.find(payload["user_id"])
            rescue JWT::DecodeError, ActiveRecord::RecordNotFound
              error!({ error: "Invalid token" }, 401)
            end
          end

          def current_user
            @current_user
          end

          def require_authentication
            authenticate_user!
          end
        end
      end
    end
  end
end
