class HsCode < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :description, presence: true
  validates :category, presence: true
  validates :unit, presence: true
  validates :tariff_rate, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Pagination
  paginates_per 20

  # Associations
  has_many :favourites, dependent: :destroy
  has_many :favourited_by_users, through: :favourites, source: :user

  # Scopes
  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :search, ->(term) {
    where("code ILIKE :term OR description ILIKE :term OR category ILIKE :term", term: "%#{term}%") if term.present?
  }
end
