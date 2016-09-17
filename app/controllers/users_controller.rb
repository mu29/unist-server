class UsersController < ApplicationController
  skip_before_action :verify_authenticate_token

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.confirm_email(@user).deliver
      render_success '이메일 인증을 하시면 회원가입이 완료됩니다.', {}, :created
    else
      render_error @user.errors.full_messages.first
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
