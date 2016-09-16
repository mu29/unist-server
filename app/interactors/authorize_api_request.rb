class AuthorizeApiRequest
  include Interactor

  def call
    user
  end

  private

  def user
    User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  end

  def decoded_auth_token
    JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    auth_header = context.headers['Authorization']
    if auth_header.present?
      auth_header.split(' ').last
    else
      context.fail!(error: 'Missing token')
    end
  end
end
