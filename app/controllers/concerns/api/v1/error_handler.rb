module Api
  module V1
    module ErrorHandler
      extend ActiveSupport::Concern

      included do
        rescue_from :all do |e|
          error!({ error: e.message }, 500)
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error!({ error: "Record not found" }, 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error!({ error: e.record.errors.full_messages }, 422)
        end
      end
    end
  end
end
