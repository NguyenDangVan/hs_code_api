class CrawlerService
  require 'nokogiri'
  require 'open-uri'

  def initialize
    @base_url = 'https://www.trade-tariff.service.gov.uk'
  end

  def crawl_hs_codes(category = nil)
    begin
      url = category ? "#{@base_url}/search?q=#{category}" : "#{@base_url}/search"
      doc = Nokogiri::HTML(URI.open(url))
      
      hs_codes = []
      
      # Extract HS codes from the page
      doc.css('.search-result').each do |result|
        code_element = result.css('.code').first
        description_element = result.css('.description').first
        category_element = result.css('.category').first
        
        next unless code_element && description_element
        
        hs_codes << {
          code: code_element.text.strip,
          description: description_element.text.strip,
          category: category_element&.text&.strip || 'General',
          unit: extract_unit(description_element.text),
          rate: extract_rate(result)
        }
      end
      
      hs_codes
    rescue => e
      Rails.logger.error "Crawler error: #{e.message}"
      []
    end
  end

  def crawl_by_code(hs_code)
    begin
      url = "#{@base_url}/commodities/#{hs_code}"
      doc = Nokogiri::HTML(URI.open(url))
      
      code_element = doc.css('.commodity-code').first
      description_element = doc.css('.commodity-description').first
      category_element = doc.css('.commodity-category').first
      rate_element = doc.css('.commodity-rate').first
      
      return nil unless code_element && description_element
      
      {
        code: code_element.text.strip,
        description: description_element.text.strip,
        category: category_element&.text&.strip || 'General',
        unit: extract_unit(description_element.text),
        rate: rate_element&.text&.to_f
      }
    rescue => e
      Rails.logger.error "Crawler error for code #{hs_code}: #{e.message}"
      nil
    end
  end

  private

  def extract_unit(description)
    # Extract unit from description (e.g., "kg", "pieces", "liters")
    units = %w[kg pieces liters meters square\ meters cubic\ meters]
    units.find { |unit| description.downcase.include?(unit) } || 'units'
  end

  def extract_rate(result_element)
    rate_text = result_element.css('.rate').first&.text
    return nil unless rate_text
    
    # Extract numeric rate from text
    rate_text.scan(/\d+\.?\d*/).first&.to_f
  end
end 