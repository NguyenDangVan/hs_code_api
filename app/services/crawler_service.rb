class CrawlerService
  require "nokogiri"
  require "open-uri"
  require "selenium-webdriver"

  def initialize
    @base_url = "https://vntr.moit.gov.vn/vi/search"
  end

  def crawl_hs_codes_with_selenium
    begin
      driver = Selenium::WebDriver.for :chrome
      driver.navigate.to @base_url

      # Click vào chương 7
      chapter7 = driver.find_element(css: 'a[data-id="07"]')
      chapter7.click
      sleep 3

      # Tìm ul class sub-07
      ul_sub_07 = driver.find_element(css: "ul.listree-submenu-items.sub-07")
      hs_codes = []

      # Lấy tất cả thẻ a trong ul class sub-07
      ul_sub_07.find_elements(css: "a").each do |a_tag|
        data_id = a_tag.attribute("data-id")
        next unless data_id =~ /^07\d{2}$/

        a_tag.click
        sleep 3

        # Tìm các thẻ a bên trong ul class sub-07xx
        ul_sub = driver.find_element(css: "ul.listree-submenu-items.sub-#{data_id}")
        ul_sub.find_elements(css: "a").each do |sub_a_tag|
          sub_data_id = sub_a_tag.attribute("data-id")
          next unless sub_data_id =~ /^07\d{4}$/

          sub_a_tag.click
          sleep 3
        end
      end

      # Lấy lại HTML sau khi đã load
      html = driver.page_source
      doc = Nokogiri::HTML(html)

      # Phân tích HTML để lấy mã HS
      ul = doc.css("ul.listree-submenu-items.sub-07")
      hs_codes = crawl_hs_codes_from_ul(ul)

      driver.quit
      hs_codes
    rescue => e
      Rails.logger.error "Crawler error (selenium): #{e.message}"
      []
    end
  end

  private

  def crawl_hs_codes_from_ul(ul)
    hs_codes = []
    ul.css("> li").each do |li|
      li.css("> a").each do |a_tag|
        data_id = a_tag["data-id"]
        title = a_tag.at_css(".title")&.text&.strip
        next unless data_id && title

        if data_id =~ /^07\d{6}$/ # node lá
          hs_code = a_tag.at_css(".no")&.text&.strip
          product = title
          hs_codes << { code: hs_code, product: product } if hs_code && product
        elsif data_id =~ /^07\d{2,4}$/ # node cha, duyệt tiếp
          hs_code = a_tag.at_css(".no")&.text&.strip
          product = title
          hs_codes << { code: hs_code, product: product } if hs_code && product

          li.css("ul").each do |ul_child|
            hs_codes.concat(crawl_hs_codes_from_ul(ul_child))
          end
        end
      end
    end
    hs_codes
  end
end
