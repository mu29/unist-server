module SessionHelper
  def sign_in(user)
    @headers = {
      'Authorization' => get_token(user),
      'Accept' => 'application/json'
    }
  end

  def get_token(user)
    params = {
      email: user.email,
      password: user.password
    }

    post '/sessions',
         params: { session: params }
    JSON.parse(response.body)['token']
  end
end
