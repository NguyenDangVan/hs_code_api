module Api
  module V1
    class Favourites < Grape::API
      before do
        authenticate_user!
      end

      namespace :favourites do
        desc "Get user favourites"
        params do
          optional :page, type: Integer, default: 1, desc: "Page number"
          optional :per_page, type: Integer, default: 20, desc: "Items per page"
        end
        get do
          favourites = current_user.favourite_hs_codes
          favourites = favourites.page(params[:page]).per(params[:per_page])

          {
            favourites: HsCodeSerializer.new(favourites).serializable_hash,
            pagination: {
              current_page: favourites.current_page,
              total_pages: favourites.total_pages,
              total_count: favourites.total_count,
              per_page: favourites.limit_value
            }
          }
        end

        desc "Add HS code to favourites"
        params do
          requires :hs_code_id, type: Integer, desc: "HS Code ID"
        end
        post do
          hs_code = HsCode.find(params[:hs_code_id])
          favourite = current_user.favourites.build(hs_code: hs_code)

          if favourite.save
            {
              message: "HS Code added to favourites successfully",
              favourite: HsCodeSerializer.new(hs_code).serializable_hash
            }
          else
            error!({ error: favourite.errors.full_messages }, 422)
          end
        end

        desc "Remove HS code from favourites"
        params do
          requires :hs_code_id, type: Integer, desc: "HS Code ID"
        end
        delete ":hs_code_id" do
          favourite = current_user.favourites.find_by(hs_code_id: params[:hs_code_id])

          if favourite
            favourite.destroy
            { message: "HS Code removed from favourites successfully" }
          else
            error!({ error: "HS Code not found in favourites" }, 404)
          end
        end

        desc "Check if HS code is favourited"
        params do
          requires :hs_code_id, type: Integer, desc: "HS Code ID"
        end
        get ":hs_code_id" do
          is_favourited = current_user.favourites.exists?(hs_code_id: params[:hs_code_id])
          { is_favourited: is_favourited }
        end
      end
    end
  end
end
