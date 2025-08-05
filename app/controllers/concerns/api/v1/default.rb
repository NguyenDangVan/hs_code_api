module Api
  module V1
    module Default
      extend ActiveSupport::Concern

      included do
        prefix :api
        version :v1
        default_format :json
      end
    end
  end
end
