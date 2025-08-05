class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  has_many :favourites, dependent: :destroy
  has_many :favourite_hs_codes, through: :favourites, source: :hs_code

  private

  def password_required?
    new_record? || password.present?
  end
end
