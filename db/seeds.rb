# This file should ensure the existence of records required to run the application in every environment (product_nameion,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


data = [
  { code: "0701", product_name: "Khoai tây, tươi hoặc ướp lạnh.", description: "Khoai tây dùng làm thực phẩm", category: "Rau củ", unit: "kg" },
  { code: "07011000", product_name: "- Để làm giống", description: "Khoai tây giống", category: "Rau củ", unit: "kg" },
  { code: "070190", product_name: "- Loại khác:", description: "Khoai tây loại khác", category: "Rau củ", unit: "kg" },
  { code: "07019010", product_name: "- - Loại thường dùng để làm khoai tây chiên (chipping potatoes)", description: "Khoai tây chiên", category: "Rau củ", unit: "kg" },
  { code: "07019090", product_name: "- - Loại khác", description: "Khoai tây loại khác", category: "Rau củ", unit: "kg" },
  { code: "07020000", product_name: "Cà chua, tươi hoặc ướp lạnh.", description: "Cà chua dùng làm thực phẩm", category: "Rau củ", unit: "kg" },
  { code: "0703", product_name: "Hành tây, hành, hẹ, tỏi, tỏi tây và các loại rau họ hành, tỏi khác, tươi hoặc ướp lạnh.", description: "Các loại rau họ hành", category: "Rau củ", unit: "kg" },
  { code: "0704", product_name: "Bắp cải, súp lơ , su hào, cải xoăn và cây họ bắp cải ăn được tương tự, tươi hoặc ướp lạnh.", description: "Các loại rau họ bắp cải", category: "Rau củ", unit: "kg" },
  { code: "0705", product_name: "Rau diếp, xà lách (Lactuca sativa) và rau diếp xoăn (Cichorium spp.), tươi hoặc ướp lạnh.", description: "Rau diếp và xà lách", category: "Rau củ", unit: "kg" },
  { code: "0706", product_name: "Cà rốt, củ cải, củ bền làm sa-lát, diếp củ (salsify), cần củ (celeriac), củ cải ri (radish) và các loại củ rễ ăn được tương tự, tươi hoặc ướp lạnh.", description: "Các loại củ rễ", category: "Rau củ", unit: "kg" },
  { code: "07070000", product_name: "Dưa chuột và dưa chuột ri, tươi hoặc ướp lạnh.", description: "Dưa chuột", category: "Rau củ", unit: "kg" },
  { code: "0708", product_name: "Rau đậu, đã hoặc chưa bóc vỏ, tươi hoặc ướp lạnh.", description: "Rau đậu", category: "Rau củ", unit: "kg" },
  { code: "0709", product_name: "Rau khác, tươi hoặc ướp lạnh.", description: "Các loại rau khác", category: "Rau củ", unit: "kg" },
  { code: "0710", product_name: "Rau các loại (đã hoặc chưa hấp chín hoặc luộc chín trong nước), đông lạnh.", description: "Rau đông lạnh", category: "Rau củ", unit: "kg" },
  { code: "0711", product_name: "Rau các loại đã bảo quản tạm thời (ví dụ, bằng khí sunphurơ, ngâm nước muối, ngâm nước lưu huỳnh hoặc ngâm trong dung dịch bảo quản khác), nhưng không ăn ngay được.", description: "Rau bảo quản tạm thời", category: "Rau củ", unit: "kg" },
  { code: "0712", product_name: "Rau khô, ở dạng nguyên, cắt, thái lát, vụn hoặc ở dạng bột, nhưng chưa chế biến thêm.", description: "Rau khô", category: "Rau củ", unit: "kg" },
  { code: "0713", product_name: "Các loại rau đậu khô, đã bóc vỏ quả, đã hoặc chưa bóc vỏ hạt hoặc làm vỡ hạt.", description: "Rau đậu khô", category: "Rau củ", unit: "kg" },
  { code: "0714", product_name: "Sắn, củ dong, củ lan, a-ti-sô Jerusalem, khoai lang và các loại củ và rễ tương tự có hàm lượng tinh bột hoặc inulin cao, tươi, ướp lạnh, đông lạnh hoặc khô, đã hoặc chưa thái lát hoặc làm thành dạng viên; lõi cây cọ sago.", description: "Các loại củ và rễ giàu tinh bột", category: "Rau củ", unit: "kg" }
]

data.each do |entry|
  HsCode.create!(entry)
end
