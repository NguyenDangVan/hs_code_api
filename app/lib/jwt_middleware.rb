class JwtMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    
    # Skip authentication for certain paths
    return @app.call(env) if skip_authentication?(request)
    
    # Extract token from Authorization header
    token = extract_token(request)
    
    if token && JwtService.valid_token?(token)
      user_id = JwtService.extract_user_id(token)
      user = User.find_by(id: user_id)
      
      if user
        # Add user to environment for use in controllers
        env['current_user'] = user
        @app.call(env)
      else
        unauthorized_response
      end
    else
      unauthorized_response
    end
  end

  private

  def skip_authentication?(request)
    # Skip authentication for these paths
    skip_paths = [
      '/api/v1/auth/register',
      '/api/v1/auth/login',
      '/api/v1/health'
    ]
    
    skip_paths.any? { |path| request.path.start_with?(path) }
  end

  def extract_token(request)
    auth_header = request.get_header('HTTP_AUTHORIZATION')
    return nil unless auth_header
    
    # Extract token from "Bearer <token>" format
    auth_header.split(' ').last
  end

  def unauthorized_response
    [
      401,
      { 'Content-Type' => 'application/json' },
      [{ error: 'Unauthorized' }.to_json]
    ]
  end
end 