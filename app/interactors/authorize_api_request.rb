class AuthorizeApiRequest
  include Interactor

  def call
    context.user = user
  end

  private

  def user
    return unless decoded_auth_token
    user = User.find(decoded_auth_token[:user_id])
    user if user.confirmed
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
