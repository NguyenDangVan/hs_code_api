class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :created_at, :updated_at

  # Exclude sensitive information like password_digest
  def self.attributes_to_serialize
    [:id, :email, :created_at, :updated_at]
  end
end 