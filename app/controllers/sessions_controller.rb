class SessionsController < ApplicationController
  def create
    result = AuthenticateUser.call(session_params)

    if result.success?
      render_success '성공적으로 로그인 하였습니다.', token: result.token
    else
      render_error result.error, :unauthorized
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
