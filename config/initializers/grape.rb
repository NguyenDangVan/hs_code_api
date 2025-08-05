# Grape API configuration
Grape.configure do |config|
  # Enable parameter validation
  # config.param_builder = Grape::Extensions::Hashie::Mash::ParamBuilder

  # Enable JSON API format
  config.format = :json
  config.default_format = :json

  # Enable CORS
  config.middleware do
    use Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [ :get, :post, :put, :delete, :options ]
      end
    end
  end
end
