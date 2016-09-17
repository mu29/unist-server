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

  def confirm_email
    user = User.find_by(confirm_token: params[:id])
    if user && user.update(confirmed: true)
      render_success '성공적으로 인증되었습니다.'
    else
      render_error '인증에 실패했습니다.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
