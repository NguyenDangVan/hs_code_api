module Api
  module V1
    class Auth < Grape::API
      namespace :auth do
        desc "Register a new user"
        params do
          requires :email, type: String, desc: "User email"
          requires :password, type: String, desc: "User password"
          requires :password_confirmation, type: String, desc: "Password confirmation"
        end
        post :register do
          user = User.new(
            email: params[:email],
            password: params[:password],
            password_confirmation: params[:password_confirmation]
          )

          if user.save
            token = JwtService.encode(user_id: user.id)
            status 201
            {
              message: "User registered successfully",
              token: token,
              user: UserSerializer.new(user).serializable_hash
            }
          else
            error!({ error: user.errors.full_messages }, 422)
          end
        end

        desc "Login user"
        params do
          requires :email, type: String, desc: "User email"
          requires :password, type: String, desc: "User password"
        end
        post :login do
          user = User.find_by(email: params[:email])

          if user&.authenticate(params[:password])
            token = JwtService.encode(user_id: user.id)
            status 200
            {
              message: "Login successful",
              token: token,
              user: UserSerializer.new(user).serializable_hash
            }
          else
            error!({ error: "Invalid email or password" }, 401)
          end
        end
      end
    end
  end
end
