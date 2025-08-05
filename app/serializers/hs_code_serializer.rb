class HsCodeSerializer
  include JSONAPI::Serializer

  attributes :id, :code, :description, :category, :unit, :tariff_rate, :created_at, :updated_at

  # Custom serialization for single object
  def self.serialize(hs_code)
    {
      id: hs_code.id,
      code: hs_code.code,
      description: hs_code.description,
      category: hs_code.category,
      unit: hs_code.unit,
      tariff_rate: hs_code.tariff_rate,
      created_at: hs_code.created_at,
      updated_at: hs_code.updated_at
    }
  end

  # Custom serialization for collection
  def self.serialize_collection(hs_codes)
    hs_codes.map { |hs_code| serialize(hs_code) }
  end
end
