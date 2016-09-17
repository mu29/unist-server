class AuthenticateUser
  include Interactor

  def call
    context.token = JsonWebToken.encode(user_id: user.id)
  end

  private

  def user
    user = User.find_by(email: context.email)
    if user && user.authenticate(context.password) && user.confirmed
      user
    else
      context.fail!(error: '아이디, 비밀번호, 메일 인증 여부를 확인해주세요.')
    end
  end
end
