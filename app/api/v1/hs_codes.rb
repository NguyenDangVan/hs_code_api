module Api
  module V1
    class HsCodes < Grape::API
      before do
        authenticate_user!
      end

      namespace :hs_codes do
        desc 'Get all HS codes with pagination'
        params do
          optional :page, type: Integer, default: 1, desc: 'Page number'
          optional :per_page, type: Integer, default: 20, desc: 'Items per page'
          optional :search, type: String, desc: 'Search term'
        end
        get do
          hs_codes = HsCode.all
          
          if params[:search].present?
            hs_codes = hs_codes.where(
              'code ILIKE :search OR description ILIKE :search OR category ILIKE :search',
              search: "%#{params[:search]}%"
            )
          end
          
          hs_codes = hs_codes.page(params[:page]).per(params[:per_page])
          
          {
            hs_codes: HsCodeSerializer.new(hs_codes).as_json,
            pagination: {
              current_page: hs_codes.current_page,
              total_pages: hs_codes.total_pages,
              total_count: hs_codes.total_count,
              per_page: hs_codes.limit_value
            }
          }
        end

        desc 'Get a specific HS code'
        params do
          requires :id, type: Integer, desc: 'HS Code ID'
        end
        get ':id' do
          hs_code = HsCode.find(params[:id])
          HsCodeSerializer.new(hs_code).as_json
        end

        desc 'Export HS codes to CSV'
        params do
          optional :search, type: String, desc: 'Search term for filtering'
        end
        get :export do
          ExportHsCodesWorker.perform_async(current_user.id, params[:search])
          { message: 'Export job started successfully' }
        end
      end

      private

      def authenticate_user!
        token = headers['Authorization']&.split(' ')&.last
        error!({ error: 'Token is missing' }, 401) unless token
        
        begin
          payload = JwtService.decode(token)
          @current_user = User.find(payload['user_id'])
        rescue JWT::DecodeError, ActiveRecord::RecordNotFound
          error!({ error: 'Invalid token' }, 401)
        end
      end

      def current_user
        @current_user
      end
    end
  end
end 