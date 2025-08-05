class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :hs_code

  validates :user_id, uniqueness: { scope: :hs_code_id, message: "HS code already favourited" }
end
