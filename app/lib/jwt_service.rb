class JwtService
  SECRET_KEY = Rails.application.credentials.secret_key_base || "your-secret-key"
  ALGORITHM = "HS256"

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM })
    decoded[0]
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT decode error: #{e.message}"
    nil
  rescue JWT::ExpiredSignature => e
    Rails.logger.error "JWT expired: #{e.message}"
    nil
  end

  def self.valid_token?(token)
    decode(token).present?
  end

  def self.extract_user_id(token)
    payload = decode(token)
    payload&.dig("user_id")
  end
end
