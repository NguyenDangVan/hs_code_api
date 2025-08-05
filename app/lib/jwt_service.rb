class JwtService
  SECRET_KEY = Rails.application.credentials.secret_key_base || "jwt_secret_key"
  ALGORITHM = "HS256"

  def self.encode(payload, expiration = 24.hours.from_now)
    payload[:exp] = expiration.to_i
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM })
    decoded[0]
  rescue JWT::ExpiredSignature
    Rails.logger.info "JWT token has expired"
    nil
  rescue JWT::DecodeError => e
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
