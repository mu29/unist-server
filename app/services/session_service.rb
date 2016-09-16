class SessionService
  def authenticate(email, password)
    @email = email
    @password = password
    JsonWebToken.encode(user_id: user.id) if user
  end

  def authenticate_with_token(headers = {})
    @headers = headers
    User.find(decoded_auth_token[:user_id])
  end

  private

  attr_reader :email, :password, :headers

  def user
    user = User.find_by(email: email)
    user if user && user.authenticate(password)
  end

  def decoded_auth_token
    JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    headers['Authorization'].split(' ').last if headers['Authorization']
  end
end
