class HsCode < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :description, presence: true
  validates :category, presence: true
  validates :unit, presence: true
  validates :rate, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Pagination
  paginates_per 20

  # Scopes
  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :search, ->(term) { 
    where('code ILIKE :term OR description ILIKE :term OR category ILIKE :term', term: "%#{term}%") if term.present?
  }



  def self.export_to_csv(search_term = nil)
    scope = all
    scope = scope.search(search_term) if search_term.present?
    
    require 'csv'
    CSV.generate do |csv|
      csv << ['Code', 'Description', 'Category', 'Unit', 'Rate', 'Created At', 'Updated At']
      scope.find_each do |hs_code|
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
end
