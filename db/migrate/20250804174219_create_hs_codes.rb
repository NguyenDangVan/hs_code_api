class CreateHsCodes < ActiveRecord::Migration[8.0]
  def change
    create_table :hs_codes do |t|
      t.string :code
      t.string :product_name
      t.text :description
      t.string :category
      t.decimal :tariff_rate
      t.string :unit
      t.text :notes

      t.timestamps
    end
    add_index :hs_codes, :code, unique: true
  end
end

# | Trường | Mục đích |
# |--------|----------|
# | `code` | Mã HS Code (unique) |
# | `product_name` | **Tên sản phẩm** - để tìm kiếm theo tên |
# | `description` | Mô tả chi tiết sản phẩm |
# | `category` | Danh mục sản phẩm |
# | `tariff_rate` | Thuế suất |
# | `unit` | Đơn vị tính |
# | `notes` | Ghi chú bổ sung |
