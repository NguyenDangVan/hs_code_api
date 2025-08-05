class ExportHsCodesWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3, backtrace: true

  def perform(user_id, search_term = nil)
    begin
      Rails.logger.info "Starting HS codes export for user #{user_id}"
      
      user = User.find(user_id)
      hs_codes = HsCode.all
      
      # Apply search filter if provided
      if search_term.present?
        hs_codes = hs_codes.where(
          'code ILIKE :search OR description ILIKE :search OR category ILIKE :search',
          search: "%#{search_term}%"
        )
      end
      
      # Generate CSV file
      csv_data = generate_csv(hs_codes)
      
      # Save to temporary file
      file_path = Rails.root.join('tmp', "hs_codes_export_#{user_id}_#{Time.current.to_i}.csv")
      File.write(file_path, csv_data)
      
      Rails.logger.info "Export completed: #{hs_codes.count} records exported to #{file_path}"
      
      # You could implement file delivery here (email, S3 upload, etc.)
      deliver_export_file(user, file_path)
      
    rescue => e
      Rails.logger.error "Export failed: #{e.message}"
      raise e
    end
  end

  private

  def generate_csv(hs_codes)
    require 'csv'
    
    CSV.generate do |csv|
      # Add headers
      csv << ['Code', 'Description', 'Category', 'Unit', 'Rate', 'Created At', 'Updated At']
      
      # Add data rows
      hs_codes.find_each do |hs_code|
        csv << [
          hs_code.code,
          hs_code.description,
          hs_code.category,
          hs_code.unit,
          hs_code.rate,
          hs_code.created_at,
          hs_code.updated_at
        ]
      end
    end
  end

  def deliver_export_file(user, file_path)
    # This could be implemented to:
    # 1. Send email with attachment
    # 2. Upload to S3 and send download link
    # 3. Store in user's export history
    Rails.logger.info "Export file ready for user #{user.email}: #{file_path}"
    
    # For now, just log the completion
    # In a real implementation, you might send an email like:
    # ExportMailer.completion_notification(user, file_path).deliver_now
  end
end 