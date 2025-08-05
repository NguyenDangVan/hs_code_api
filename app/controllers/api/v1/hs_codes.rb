module Api
  module V1
    class HsCodes < Grape::API
      namespace :hs_codes do
        desc "Get all HS codes with pagination"
        params do
          optional :page, type: Integer, default: 1, desc: "Page number"
          optional :per_page, type: Integer, default: 20, desc: "Items per page"
          optional :search, type: String, desc: "Search term"
        end
        get do
          hs_codes = HsCode.all

          if params[:search].present?
            hs_codes = hs_codes.where(
              "code ILIKE :search OR description ILIKE :search OR category ILIKE :search",
              search: "%#{params[:search]}%"
            )
          end

          hs_codes = hs_codes.page(params[:page]).per(params[:per_page])

          {
            hs_codes: HsCodeSerializer.new(hs_codes).serializable_hash,
            pagination: {
              current_page: hs_codes.current_page,
              total_pages: hs_codes.total_pages,
              total_count: hs_codes.total_count,
              per_page: hs_codes.limit_value
            }
          }
        end

        desc "Get a specific HS code"
        params do
          requires :id, type: Integer, desc: "HS Code ID"
        end
        get ":id" do
          hs_code = HsCode.find(params[:id])
          HsCodeSerializer.new(hs_code).serializable_hash
        end
      end
    end
  end
end
